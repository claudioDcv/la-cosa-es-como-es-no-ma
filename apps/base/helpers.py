import json
from django.contrib.staticfiles.templatetags.staticfiles import static

from apps.base.models import Profile, Parameter
from apps.term.models import Course, FinalIndicatorEvaluation


def get_param(*args, **kwargs):
    key = kwargs['code']
    is_static = True if kwargs.get('static', 'no') == 'yes' else False

    program = kwargs['program_code'] if kwargs.get('program_code') else ''

    prefix = getattr(kwargs, 'prefix', '')
    text = getattr(kwargs, 'default_text', '--')
    try:
        if program:
            text = Parameter.objects.get(program__code=program, code=key).value
        else:
            text = Parameter.objects.get(code=key).value
    except Exception as e:
        if is_static:
            return static(prefix + text)
        return prefix + text
    if is_static:
        return static(prefix + text)
    return prefix + text


def get_score():
    return json.loads(get_param(code='score'))


def evaluated_with_indicator(course_id, evaluated):
    order_by = '-id'
    course = Course.objects.get(pk=course_id)
    total_indicators = course.survey.indicator.all()

    indicator_list = FinalIndicatorEvaluation.objects.filter(
        course=course, evaluated=evaluated).order_by(order_by).all()
    indicator_whitout_evaluated = course.survey.indicator.exclude(
        pk__in=[x.indicator_id for x in indicator_list],
    ).order_by(order_by)

    total_achievement = 0
    total_half_percent = 0

    for indicator in indicator_list:
        total_achievement = total_achievement + indicator.value

    if len(indicator_list) is not 0:
        half = total_achievement / len(indicator_list)
    else:
        half = 0

    half_percent = (half * 100) / float(get_score()['max'])
    total_half_percent = total_half_percent + half_percent

    return {
        'user': evaluated,
        'indicator_list': indicator_list,
        'score': get_score(),
        'total_achievement': total_achievement,
        'half': half,
        'half_percent': half_percent,
        'str_half_percent': (
            str(half_percent)[:4]) if len(str(half_percent)
                                          ) > 4 else str(half_percent),
        'total_indicators': len(total_indicators),
        'indicator_evaluated': (
            len(indicator_list) * 100) / len(total_indicators),
        'indicator_whitout_evaluated': indicator_whitout_evaluated,
    }


def student_list_with_indicator(pk):
    context = {}
    course = Course.objects.defer(
        'period',
        'section',
        'description',
        'feedback',
    ).get(pk=pk)

    total_indicators = course.survey.indicator.all()
    students = course.students.values(
        'id',
        'first_name',
        'last_name',
        'email',
        'username',
        ).all()

    total_half_percent = 0
    students_with_indicator = []
    students_with_evaluation = 0

    for student in students:
        indicator_list = FinalIndicatorEvaluation.objects.filter(
            course_id=course.id,
            evaluated=student['id'],
        ).defer('tempfinalindicatorevaluation', 'created_ts', 'evaluator').order_by('-id').all()

        total_achievement = 0
        for indicator in indicator_list:
            total_achievement = total_achievement + indicator.value

        if len(indicator_list) is not 0:
            students_with_evaluation = students_with_evaluation + 1
            half = total_achievement / len(indicator_list)
        else:
            half = 0

        # Logro medio de todos los indicadores para el curso
        half_percent = (half * 100) / float(get_score()['max'])
        total_half_percent = total_half_percent + half_percent

        students_with_indicator.append({
            'user': student,
            'indicator_list': indicator_list,
            'half': half,
            'half_percent': half_percent,
            'str_half_percent': (
                str(half_percent)[:4]) if len(str(half_percent)) > 4 else str(
                    half_percent),
            'indicator_evaluated': (
                len(indicator_list) * 100) / len(total_indicators),
        })

    if students_with_evaluation is not 0:
        total_half_percent = total_half_percent / students_with_evaluation
    else:
        total_half_percent = 0
    context['total_half_percent'] = total_half_percent
    context['total_indicators'] = len(total_indicators)
    context['students_with_indicator'] = students_with_indicator

    return context


def has_profile(*args, **kwargs):
    profile = kwargs['eval']
    current_profile = kwargs['curr']
    current_profile_name = ''
    for prof in current_profile.ROLE_CHOICES:
        if prof[0] == current_profile.id:
            current_profile_name = prof[1]
    return current_profile_name == profile
