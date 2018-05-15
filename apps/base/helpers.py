import json
from django.contrib.staticfiles.templatetags.staticfiles import static

from apps.base.models import Profile, Parameter
from apps.term.models import Course, FinalIndicatorEvaluation, Feedback
from django.db.models import Count

from operator import itemgetter

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

    '''
        indicator_id = integer
        value = double
        description = string
        name = string
        evaluated = bool
    '''

    indicator_merge_values = []

    def create_indicator(indicator):
        ind = indicator.indicator
        return {
            'id': ind.id,
            'id_eval': indicator.id, 
            'name': ind.name,
            'description': ind.description,
            'value': indicator.value,
            'skill__name': ind.skill.name,
            'is_eval': True,
        }
    def create_indicator_no_eval(indicator):
        ind = indicator
        return {
            'id': ind.id,
            'id_eval': 0,
            'name': ind.name,
            'description': ind.description,
            'value': -1,
            'skill__name': ind.skill.name,
            'is_eval': False,
        }

    for indicator in indicator_list:
        indicator_merge_values.append(create_indicator(indicator))
        total_achievement = total_achievement + indicator.value

    for indicator in indicator_whitout_evaluated:
        indicator_merge_values.append(create_indicator_no_eval(indicator))

    indicator_merge_values = sorted(indicator_merge_values, key=itemgetter('id'), reverse=False)

    if len(indicator_list) is not 0:
        half = total_achievement / len(indicator_list)
    else:
        half = 0

    half_percent = (half * 100) / float(get_score()['max'])
    total_half_percent = total_half_percent + half_percent

    # merger indicators and ordered by id

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
        'indicator_merge_values': indicator_merge_values,
    }


def student_list_with_indicator(pk, score_out = None):
    context = {}
    score = score_out

    if score_out == None:
        score = get_score()

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
        'image_profile',
        ).order_by('last_name').all()

    total_half_percent = 0
    students_with_indicator = []
    students_with_evaluation = 0

    student_count = course.students.count()

    # FEEDBACK QUERY
    feedbacks = Feedback.objects.filter(
        course_id=course.id).values('evaluated_id').annotate(total=Count('id'))
    feedbacks_obj = {}
    for feed in feedbacks:
        feedbacks_obj[feed['evaluated_id']] = feed['total']
    #FINALINDICATOREVALUATION QUERY
    final_indicator_evaluation = FinalIndicatorEvaluation.objects.filter(
            course_id=course.id,
        ).defer(
            'tempfinalindicatorevaluation',
            'created_ts',
            'evaluator',
            'evaluated',
        ).all()

    fie_obj = {}
    total_fie_obj = 0
    total_fie_obj = fie_iterator(final_indicator_evaluation, fie_obj, total_fie_obj)

    students_with_evaluation, total_half_percent = student_iterator(students, fie_obj, students_with_evaluation, score, total_half_percent, students_with_indicator, total_indicators, feedbacks_obj)

    if students_with_evaluation is not 0:
        total_half_percent = total_half_percent / students_with_evaluation
    else:
        total_half_percent = 0
    
    context['total_half_percent'] = total_half_percent
    context['str_total_half_percent'] = (str(total_half_percent)[:4]) if len(str(total_half_percent)) > 4 else str(total_half_percent)
    context['total_indicators'] = len(total_indicators)
    context['students_with_indicator'] = students_with_indicator
    context['course_evaluation_progress'] = int((total_fie_obj * 100 ) / student_count)
    context['course_evaluation_include_indicator_progress'] = int((total_fie_obj * 100 ) / (student_count * len(total_indicators)))

    return context

def fie_iterator(final_indicator_evaluation, fie_obj, total_fie_obj):
    for fie in final_indicator_evaluation:
        evaluated_id = fie.evaluated_id

        if fie_obj.get(evaluated_id, False) == False:
            fie_obj[evaluated_id] = []

        if fie_obj.get(evaluated_id) is not None:
            fie_obj.get(evaluated_id).append({
                'id': fie.id,
                'value': fie.value,
            })
        total_fie_obj += 1
    return total_fie_obj

def student_iterator(students, fie_obj, students_with_evaluation, score, total_half_percent, students_with_indicator, total_indicators, feedbacks_obj):
    for student in students:

        indicator_list = fie_obj.get(student.get('id'), [])

        total_achievement = 0
        for indicator in indicator_list:
            total_achievement = total_achievement + indicator.get('value')

        if len(indicator_list) is not 0:
            students_with_evaluation = students_with_evaluation + 1
            half = total_achievement / len(indicator_list)


        else:
            half = 0

        # Logro medio de todos los indicadores para el curso
        half_percent = (half * 100) / float(score['max'])
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
            'feedback_count': feedbacks_obj.get(student['id'], 0),
        })
    return students_with_evaluation, total_half_percent


def has_profile(*args, **kwargs):
    profile = kwargs['eval']
    current_profile = kwargs['curr']
    current_profile_name = ''
    for prof in current_profile.ROLE_CHOICES:
        if prof[0] == current_profile.id:
            current_profile_name = prof[1]
    return current_profile_name == profile