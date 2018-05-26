import json

from django.db import models

from apps.base.models import DescriptiveModel
from apps.base.models import Parameter
from apps.base.models import SoftDeleteTSModel
from apps.base.models import User
from apps.core.models import Indicator
from apps.core.models import Program
from apps.core.models import Skill
from apps.core.models import Subject
from apps.business.models import Campus
from apps.business.models import Period
from apps.business.models import Survey

indicator_values = json.loads(Parameter.objects.get(code='score').value)
MIN_INDICATOR_VALUE = int(indicator_values['min'])
MAX_INDICATOR_VALUE = int(indicator_values['max'])

class Course(SoftDeleteTSModel, DescriptiveModel):
    code = models.CharField(max_length=100)
    section = models.CharField(max_length=250, verbose_name='Sección')

    checksum = models.CharField(blank=True, max_length=100)

    teachers = models.ManyToManyField(
        User,
        related_name='teachers',
        blank=True,
        # limit_choices_to={
        #     'id__in':User._product_list,
        # },
    )
    students = models.ManyToManyField(
        User,
        blank=True,
        related_name='students',
    )

    period = models.ForeignKey(Period, on_delete=models.CASCADE,)
    campus = models.ForeignKey(Campus, on_delete=models.CASCADE,)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE,)
    survey = models.ForeignKey(Survey, on_delete=models.CASCADE,)

    class Meta:
        unique_together = (('code', 'section'),)
        verbose_name = 'curso'
        verbose_name_plural = 'cursos'

    @property
    def total_evaluated_values(self):
        return FinalIndicatorEvaluation.objects.filter(
            course=self,
        ).values_list('value', flat=True)

    @property
    def progress_level(self):
        students = self.students.all()
        indicators = self.survey.indicator.all()
        teachers = self.teachers.all()

        len_total_values = len(students) * len(indicators) * len(teachers)

        len_total_evaluated_values = len(self.total_evaluated_values)

        return float(len_total_evaluated_values)/len_total_values if len_total_values > 0 else None

    @property
    def goal_level(self):
        len_total_evaluated_values = len(self.total_evaluated_values)
        sum_total_evaluated_values = sum(self.total_evaluated_values)

        max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

        return float(sum_total_evaluated_values)/max_total_evaluated_values if max_total_evaluated_values > 0 else None

    @property
    def skills(self):
        return set([i.skill for i in self.survey.indicator.all()])

    def total_evaluated_values_by_skill(self, skill):
        return FinalIndicatorEvaluation.objects.filter(
            course=self,
            indicator__skill=skill,
        ).values_list('value', flat=True)

    def progress_level_by_skill(self, skill):
        students = self.students.all()
        indicators = self.survey.indicator.filter(skill=skill)
        teachers = self.teachers.all()

        len_total_values = len(students) * len(indicators) * len(teachers)

        len_total_evaluated_values = len(self.total_evaluated_values_by_skill(skill))

        return float(len_total_evaluated_values)/len_total_values if len_total_values > 0 else None

    def goal_level_by_skill(self, skill):
        total_evaluated_values = self.total_evaluated_values_by_skill(skill)
        len_total_evaluated_values = len(total_evaluated_values)
        sum_total_evaluated_values = sum(total_evaluated_values)

        max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

        return float(sum_total_evaluated_values)/max_total_evaluated_values if max_total_evaluated_values > 0 else None

    @classmethod
    def all_json(
        cls,
        time_status='active', # 'active', 'past', 'future', 'all' # Ok 
        program=None, # Ok
        period=None, # Ok
        campus=None, # Ok
        teacher=None, # Ok
        student=None, # Ok
        subject=None, # Ok
        skill=None, # Ok
        progress_level_not_none=None, # None (all), True, False
        progress_level_less_than=None,
        progress_level_greater_than=None,
        progress_level_less_or_equal_than=None,
        progress_level_greater_or_equal_than=None,
        goal_level_not_none=None, # None (all), True, False
        goal_level_less_than=None,
        goal_level_greater_than=None,
        goal_level_less_or_equal_than=None,
        goal_level_greater_or_equal_than=None,
        order_by=None,
        show_skills=False,
    ):
        courses = Course.objects.all()

        if period is not None:
            courses = courses.filter(period=period)
        elif time_status != 'all':
            if time_status == 'active':
                courses = courses.filter(period__in=Period.all_active())
            elif time_status == 'past':
                courses = courses.filter(period__in=Period.all_past())
            elif time_status == 'future':
                courses = courses.filter(period__in=Period.all_future())

        if program is not None:
            courses = courses.filter(period__program=program)

        if subject is not None:
            courses = courses.filter(subject=subject)

        if campus is not None:
            courses = courses.filter(campus=campus)

        if skill is not None:
            courses = courses.filter(survey__indicator__skill=skill)

        if teacher is not None:
            courses = courses.filter(teachers=teacher)

        if student is not None:
            courses = courses.filter(students=student)

        if progress_level_not_none is not None:
            if progress_level_not_none:
                courses = [c for c in courses if c.progress_level is not None]        
            else:
                courses = [c for c in courses if c.progress_level is None]        

        if progress_level_less_than is not None:
            courses = [c for c in courses if c.progress_level is not None and c.progress_level < progress_level_less_than]        

        if progress_level_greater_than is not None:
            courses = [c for c in courses if c.progress_level is not None and c.progress_level > progress_level_greater_than]        

        if progress_level_less_or_equal_than is not None:
            courses = [c for c in courses if c.progress_level is not None and c.progress_level <= progress_level_less_or_equal_than]        

        if progress_level_greater_or_equal_than is not None:
            courses = [c for c in courses if c.progress_level is not None and c.progress_level >= progress_level_greater_or_equal_than]        

        if goal_level_not_none is not None:
            if goal_level_not_none:
                courses = [c for c in courses if c.goal_level is not None]        
            else:
                courses = [c for c in courses if c.goal_level is None]        

        if goal_level_less_than is not None:
            courses = [c for c in courses if c.goal_level is not None and c.goal_level < goal_level_less_than]        

        if goal_level_greater_than is not None:
            courses = [c for c in courses if c.goal_level is not None and c.goal_level > goal_level_greater_than]        

        if goal_level_less_or_equal_than is not None:
            courses = [c for c in courses if c.goal_level is not None and c.goal_level <= goal_level_less_or_equal_than]        

        if goal_level_greater_or_equal_than is not None:
            courses = [c for c in courses if c.goal_level is not None and c.goal_level >= goal_level_greater_or_equal_than]

        result = []

        for c in courses:

            json_course = {
                'id': c.id,
                'name': c.name,
                'code': c.code,
                'section': c.section,
                'period': c.period.name,
                'campus': c.campus.name,
                'subject': c.subject.name,
                'survey': c.survey.name,
                'program': c.period.program.name,
                'teachers': [t.email for t in c.teachers.order_by('email').all()],
                'students': [s.email for s in c.students.order_by('email').all()],
                'time_status': c.period.time_status,
                'progress_level': c.progress_level,
                'goal_level': c.goal_level,   
            }

            if show_skills:
                skills = []

                for s in c.skills:
                    skills.append({
                        'name': s.name,
                        'code': s.code,
                        'progress_level': c.progress_level_by_skill(s),
                        'goal_level': c.goal_level_by_skill(s),                    
                    })

                json_course.update({  
                    'skills': skills,             
                })

            result.append(json_course)

        if order_by is not None:
            reverse = '-' in order_by
            key = order_by.replace('-','')
            result.sort(key = lambda c: c[key] if c[key] is not None else 0, reverse=reverse)

        return json.dumps(result)


class Feedback(SoftDeleteTSModel):
    score = models.FloatField(blank=True, null=True)
    message = models.TextField(max_length=500, verbose_name='Mensaje')
    evaluator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='feedback_evaluator')
    evaluated = models.ForeignKey(User, on_delete=models.CASCADE, related_name='feedback_evaluated')
    course = models.ForeignKey(Course, on_delete=models.CASCADE,)


class TempFeedbackMessage(SoftDeleteTSModel):
    message = models.TextField(max_length=500, verbose_name='Mensaje')
    feedback = models.ForeignKey(Feedback, on_delete=models.CASCADE,)


class TempFedbackScore(SoftDeleteTSModel):
    score = models.FloatField(blank=True, null=True)
    feedback = models.ForeignKey(Feedback, on_delete=models.CASCADE,)


class FinalScoreEvaluation(SoftDeleteTSModel):
    value = models.FloatField()
    evaluator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='note_evaluator')
    evaluated = models.ForeignKey(User, on_delete=models.CASCADE, related_name='note_evaluated')
    course = models.ForeignKey(Course, on_delete=models.CASCADE,)

    class Meta:
        verbose_name = 'nota final (estudiante - curso)'
        verbose_name_plural = 'notas finales (estudiante - curso)'


class TempScoreEvaluation(SoftDeleteTSModel):
    value = models.FloatField()
    final_note_evaluation = models.ForeignKey(
        FinalScoreEvaluation,
        on_delete=models.CASCADE,
    )


class FinalIndicatorEvaluation(SoftDeleteTSModel):
    value = models.FloatField()

    evaluator = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='evaluator',
    )
    evaluated = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='evalueted',
    )
    course = models.ForeignKey(
        Course,
        on_delete=models.CASCADE,
    )
    indicator = models.ForeignKey(
        Indicator,
        on_delete=models.CASCADE,
    )

    class Meta:
        unique_together = (('indicator', 'course', 'evaluated'),)
        verbose_name = 'puntaje de indicador (estudiante - curso)'
        verbose_name_plural = 'puntajes de indicadores (estudiante - curso)'


class TempFinalIndicatorEvaluation(SoftDeleteTSModel):
    value = models.FloatField()
    final_indicator_evaluation = models.ForeignKey(
        FinalIndicatorEvaluation,
        on_delete=models.CASCADE,
    )
