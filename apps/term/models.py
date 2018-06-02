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
    def len_total_values(self):
        students = self.students.all()
        indicators = self.survey.indicator.all()
        teachers = self.teachers.all()

        return len(students) * len(indicators) * len(teachers)

    @property
    def total_evaluated_values(self):
        return FinalIndicatorEvaluation.objects.filter(
            course=self,
        ).values_list('value', flat=True)

    @property
    def progress_level(self):
        len_total_evaluated_values = len(self.total_evaluated_values)
        len_total_values = self.len_total_values
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

    @property
    def skills_groups(self):
        return set([i.skill.skill_group for i in self.survey.indicator.all()])

    def get_skills_by_skills_group(self, skills_group):
        return set([i.skill for i in self.survey.indicator.filter(skill__skill_group=skills_group)])

    def len_total_values_by_skill(self, skill):
        students = self.students.all()
        indicators = self.survey.indicator.filter(skill=skill)
        teachers = self.teachers.all()

        return len(students) * len(indicators) * len(teachers)

    def total_evaluated_values_by_skill(self, skill):
        return FinalIndicatorEvaluation.objects.filter(
            course=self,
            indicator__skill=skill,
        ).values_list('value', flat=True)

    def progress_level_by_skill(self, skill):
        len_total_evaluated_values = len(self.total_evaluated_values_by_skill(skill))
        len_total_values = self.len_total_values_by_skill(skill)
        return float(len_total_evaluated_values)/len_total_values if len_total_values > 0 else None

    def goal_level_by_skill(self, skill):
        total_evaluated_values = self.total_evaluated_values_by_skill(skill)
        len_total_evaluated_values = len(total_evaluated_values)
        sum_total_evaluated_values = sum(total_evaluated_values)

        max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

        return float(sum_total_evaluated_values)/max_total_evaluated_values if max_total_evaluated_values > 0 else None

    def len_total_values_by_skills_group(self, skills_group):
        students = self.students.all()
        indicators = self.survey.indicator.filter(skill__skill_group=skills_group)
        teachers = self.teachers.all()

        return len(students) * len(indicators) * len(teachers)
        
    def total_evaluated_values_by_skills_group(self, skills_group):
        return FinalIndicatorEvaluation.objects.filter(
            course=self,
            indicator__skill__skill_group=skills_group,
        ).values_list('value', flat=True)

    def progress_level_by_skills_group(self, skills_group):
        len_total_evaluated_values = len(self.total_evaluated_values_by_skills_group(skills_group))
        len_total_values = self.len_total_values_by_skills_group(skills_group)
        return float(len_total_evaluated_values)/len_total_values if len_total_values > 0 else None

    def goal_level_by_skills_group(self, skills_group):
        total_evaluated_values = self.total_evaluated_values_by_skills_group(skills_group)
        len_total_evaluated_values = len(total_evaluated_values)
        sum_total_evaluated_values = sum(total_evaluated_values)

        max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

        return float(sum_total_evaluated_values)/max_total_evaluated_values if max_total_evaluated_values > 0 else None

    @classmethod
    def all_json(
        cls,
        time_status='active', # 'active', 'past', 'future', 'all' # Ok 
        programs=None,
        periods=None,
        campus=None,
        teachers=None,
        students=None,
        subjects=None,
        skills=None,
        skills_groups=None,
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
        show_skills_groups=False,
        as_json=False,
    ):
        courses = Course.objects.all().distinct()

        if periods is not None:
            if type(periods) is not list:
                periods = [periods]
            if len(periods) > 0:
                courses = courses.filter(period__in=periods)
        elif time_status != 'all':
            if time_status == 'active':
                courses = courses.filter(period__in=Period.all_active())
            elif time_status == 'past':
                courses = courses.filter(period__in=Period.all_past())
            elif time_status == 'future':
                courses = courses.filter(period__in=Period.all_future())

        if programs is not None:
            if type(programs) is not list:
                programs = [programs]
            if len(programs) > 0:
                courses = courses.filter(period__program__in=programs)

        if subjects is not None:
            if type(subjects) is not list:
                subjects = [subjects]
            if len(subjects) > 0:
                courses = courses.filter(subject__in=subjects)

        if campus is not None:
            if type(campus) is not list:
                campus = [campus]
            if len(campus) > 0:
                courses = courses.filter(campus__in=campus)

        if skills is not None:
            if type(skills) is not list:
                skills = [skills]
            if len(skills) > 0:
                courses = courses.filter(survey__indicator__skill__in=skills)

        if skills_groups is not None:
            if type(skills_groups) is not list:
                skills_groups = [skills_groups]
            if len(skills_groups) > 0:
                courses = courses.filter(survey__indicator__skill__skill_group__in=skills_groups)

        if teachers is not None:
            if type(teachers) is not list:
                teachers = [teachers]
            if len(teachers) > 0:
                courses = courses.filter(teachers__in=teachers)

        if students is not None:
            if type(students) is not list:
                students = [students]
            if len(students) > 0:
                courses = courses.filter(students__in=students)

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
                        'group': s.skill_group.name,
                        'progress_level': c.progress_level_by_skill(s),
                        'goal_level': c.goal_level_by_skill(s),                    
                    })

                json_course.update({  
                    'skills': skills,             
                })

            if show_skills:
                skills_groups = []

                for s in c.skills_groups:
                    skills_groups.append({
                        'name': s.name,
                        'code': s.code,
                        'skills': [sk.name for sk in c.get_skills_by_skills_group(s)],
                        'progress_level': c.progress_level_by_skills_group(s),
                        'goal_level': c.goal_level_by_skills_group(s),                    
                    })

                json_course.update({  
                    'skills_groups': skills_groups,             
                })

            result.append(json_course)

        if order_by is not None:
            reverse = '-' in order_by
            key = order_by.replace('-','')
            result.sort(key = lambda c: c[key] if c[key] is not None else 0, reverse=reverse)

        return json.dumps(result) if as_json else result


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
