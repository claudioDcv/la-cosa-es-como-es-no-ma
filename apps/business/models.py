import json

from datetime import datetime

from django.db import models
from apps.base.models import DescriptiveModel
from apps.base.models import Parameter
from apps.base.models import SoftDeleteTSModel
from apps.core.models import Indicator
from apps.core.models import Program
from apps.core.models import Subject

indicator_values = json.loads(Parameter.objects.get(code='score').value)
MIN_INDICATOR_VALUE = int(indicator_values['min'])
MAX_INDICATOR_VALUE = int(indicator_values['max'])

class Survey(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    indicator = models.ManyToManyField(Indicator)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE,)

    class Meta:
        verbose_name = 'encuesta'


class Period(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    start_date = models.DateField()
    end_date = models.DateField()
    program = models.ForeignKey(Program, on_delete=models.CASCADE,)

    class Meta:
        verbose_name = 'periodo'

    def __str__(self):
        return '{0} {1}'.format(self.name, self.program)

    @property
    def is_active(self):
        start_date = self.start_date
        end_date = self.end_date
        now = datetime.now().date()
        return start_date <= now <= end_date

    @property
    def is_past(self):
        end_date = self.end_date
        now = datetime.now().date()
        return end_date < now

    @property
    def is_future(self):
        start_date = self.start_date
        now = datetime.now().date()
        return now < start_date

    @property
    def time_status(self):
        if self.is_active:
            return 'active'
        elif self.is_past:
            return 'past'
        elif self.is_future:
            return 'future'
        else:
            return None

    @property
    def courses(self):
        from apps.term.models import Course
        return Course.objects.filter(period=self)

    @classmethod
    def all_active(cls):
        now = datetime.now().date()
        return Period.objects.filter(
            start_date__lte=now,
            end_date__gte=now,
        )

    @classmethod
    def all_past(cls):
        now = datetime.now().date()
        return Period.objects.filter(
            end_date__lt=now,
        )

    @classmethod
    def all_future(cls):
        now = datetime.now().date()
        return Period.objects.filter(
            start_date__gt=now,
        )

    @property
    def len_total_values(self):
        len_total_values = 0
        for c in self.courses:
            len_total_values += c.len_total_values
        return len_total_values

    @property
    def total_evaluated_values(self):
        from apps.term.models import FinalIndicatorEvaluation
        return FinalIndicatorEvaluation.objects.filter(
            course__in=self.courses,
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
        return set([i.skill for c in self.courses for i in c.survey.indicator.all()])

    @property
    def skills_groups(self):
        return set([i.skill.skill_group for c in self.courses for i in c.survey.indicator.all()])

    def get_skills_by_skills_group(self, skills_group):
        return set([i.skill for c in self.courses for i in c.survey.indicator.filter(skill__skill_group=skills_group)])

    def len_total_values_by_skill(self, skill):
        len_total_values = 0
        for c in self.courses:
            len_total_values += c.len_total_values_by_skill(skill)
        return len_total_values

    def total_evaluated_values_by_skill(self, skill):
        from apps.term.models import FinalIndicatorEvaluation
        return FinalIndicatorEvaluation.objects.filter(
            course__in=self.courses,
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
        len_total_values = 0
        for c in self.courses:
            len_total_values += c.len_total_values_by_skills_group(skills_group)
        return len_total_values
        
    def total_evaluated_values_by_skills_group(self, skills_group):
        from apps.term.models import FinalIndicatorEvaluation
        return FinalIndicatorEvaluation.objects.filter(
            course__in=self.courses,
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
        q_periods = Period.objects.all().distinct()

        if periods is not None:
            if type(periods) is not list:
                periods = [periods]
            if len(periods) > 0:
                q_periods = q_periods.filter(id__in=[p.id for p in periods])
        else:
            if time_status != 'all':
                if time_status == 'active':
                    q_periods = Period.all_active()
                elif time_status == 'past':
                    q_periods = Period.all_past()
                elif time_status == 'future':
                    q_periods = Period.all_future()

            if programs is not None:
                if type(programs) is not list:
                    programs = [programs]
                if len(programs) > 0:
                    q_periods = q_periods.filter(program__in=programs)

            if progress_level_not_none is not None:
                if progress_level_not_none:
                    q_periods = [p for p in q_periods if p.progress_level is not None]        
                else:
                    q_periods = [p for p in q_periods if p.progress_level is None]        

            if progress_level_less_than is not None:
                q_periods = [p for p in q_periods if p.progress_level is not None and p.progress_level < progress_level_less_than]        

            if progress_level_greater_than is not None:
                q_periods = [p for p in q_periods if p.progress_level is not None and p.progress_level > progress_level_greater_than]        

            if progress_level_less_or_equal_than is not None:
                q_periods = [p for p in q_periods if p.progress_level is not None and p.progress_level <= progress_level_less_or_equal_than]        

            if progress_level_greater_or_equal_than is not None:
                q_periods = [p for p in q_periods if p.progress_level is not None and p.progress_level >= progress_level_greater_or_equal_than]        

            if goal_level_not_none is not None:
                if goal_level_not_none:
                    q_periods = [p for p in q_periods if p.goal_level is not None]        
                else:
                    q_periods = [p for p in q_periods if p.goal_level is None]        

            if goal_level_less_than is not None:
                q_periods = [p for p in q_periods if p.goal_level is not None and p.goal_level < goal_level_less_than]        

            if goal_level_greater_than is not None:
                q_periods = [p for p in q_periods if p.goal_level is not None and p.goal_level > goal_level_greater_than]        

            if goal_level_less_or_equal_than is not None:
                q_periods = [p for p in q_periods if p.goal_level is not None and p.goal_level <= goal_level_less_or_equal_than]        

            if goal_level_greater_or_equal_than is not None:
                q_periods = [p for p in q_periods if p.goal_level is not None and p.goal_level >= goal_level_greater_or_equal_than]

        result = []

        for p in q_periods:

            json_course = {
                'id': p.id,
                'name': p.name,
                'code': p.code,
                'start_date': p.start_date.strftime('%d/%m/%Y'),
                'end_date': p.end_date.strftime('%d/%m/%Y'),
                'program': p.program.name,
                'time_status': p.time_status,
                'progress_level': p.progress_level,
                'goal_level': p.goal_level,   
            }

            if show_skills:
                skills = []

                for s in p.skills:
                    skills.append({
                        'name': s.name,
                        'code': s.code,
                        'group': s.skill_group.name,
                        'progress_level': p.progress_level_by_skill(s),
                        'goal_level': p.goal_level_by_skill(s),                    
                    })

                json_course.update({  
                    'skills': skills,             
                })

            if show_skills_groups:
                skills_groups = []

                for s in p.skills_groups:
                    skills_groups.append({
                        'name': s.name,
                        'code': s.code,
                        'skills': [sk.name for sk in p.get_skills_by_skills_group(s)],
                        'progress_level': p.progress_level_by_skills_group(s),
                        'goal_level': p.goal_level_by_skills_group(s),                    
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

class Campus(SoftDeleteTSModel, DescriptiveModel):
    program = models.ManyToManyField(Program)

    class Meta:
        verbose_name = 'campus'
        verbose_name_plural = 'campus'
