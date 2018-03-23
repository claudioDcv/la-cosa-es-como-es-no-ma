import json

from django.views.generic.detail import DetailView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import get_object_or_404
from apps.base.views import get_context_current_profile
from django.http import Http404

from apps.core.models import Program
from apps.term.models import Course, Feedback, FinalIndicatorEvaluation
from apps.base.models import Profile, User
from apps.base.helpers import get_score, student_list_with_indicator,\
    evaluated_with_indicator
from apps.core.models import Skill, Indicator
from apps.business.models import Survey


def calc_percentage(x, total):
    return (x * 100) / total


def has_profile(current_profile, profile):
    current_profile_name = ''
    for prof in current_profile.ROLE_CHOICES:
        if prof[0] == current_profile.id:
            current_profile_name = prof[1]
    return current_profile_name == profile


def get_id_profile_by_name(name):
    prof_id = 0
    for prof in Profile.ROLE_CHOICES:
        if prof[1] == name:
            prof_id = prof[0]
    return prof_id


class SkillGroupIndexView(LoginRequiredMixin, DetailView):

    template_name = 'core/skill_group_index.html'

    def get_object(self):
        """Get obj."""
        return Course.objects.filter(
            subject__subjects_group__program__code=self.kwargs['code']
            ).only('survey_id', 'teachers', 'students')

    def get_context_data(self, **kwargs):
        """Get ctx."""
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']
        score = get_score()
        context['score'] = score

        context['program'] = Program.objects.get(code=self.kwargs['code'])
        user = self.request.user

        context = get_context_current_profile(context, self)

        if context['current_profile']:

            if has_profile(context['current_profile'], 'teacher'):
                obj = self.get_object()
                context['courses'] = obj.filter(teachers=user)

            elif has_profile(context['current_profile'], 'student'):

                #  traer todos los cursos donde participa el estudiante
                context['courses'] = obj.filter(students=user)

                #  listado de ids de las encuestas de los cursos
                survey_ids = [x.survey_id for x in context['courses']]

                # lista de encuestas
                survey_list = Survey.objects.filter(id__in=survey_ids)

                skill_ids = []
                for survey in survey_list:
                    for indicator in survey.indicator.all():
                        skill_ids.append(indicator.skill_id)

                #  ademas esta lista es unica
                # listado de indicadores y skill que pertenecen a los ramos que
                # tiene el estudiante
                skill_ids = list(set(skill_ids))

                skill_list = Skill.objects.filter(id__in=skill_ids)

                #  procedimiento para aramar listado de indicadores evaluados
                # construccion de objeto de competencias con estdiante evaluado
                final_skill_list = []
                for skill in skill_list:

                    # traer todos los indicadores de la competencia
                    indicator_list = skill.indicator_set.values(
                        'name', 'id', 'description'
                    ).all()
                    final_indicator_list = []
                    skill_value = 0
                    evaluated_at_least_once = False
                    len_final_ind_eval_list = 0
                    ind_percent_sum = 0
                    indicator_evaluated = 0

                    for indicator in indicator_list:
                        final_ind_eval_list = FinalIndicatorEvaluation.\
                            objects.filter(
                                evaluated=user,
                                indicator=indicator,
                            ).only('value').all()

                        ind_value = 0
                        is_evaluated = False
                        len_final_ind_eval_list = len(final_ind_eval_list)
                        if len_final_ind_eval_list > 0:
                            is_evaluated = True
                            indicator_evaluated = indicator_evaluated + 1
                            evaluated_at_least_once = True
                            for final_ind_eval in final_ind_eval_list:
                                ind_value = ind_value + final_ind_eval.value
                                skill_value = skill_value + final_ind_eval.value

                        #  creando dicionario para luego serializar como json
                        try:
                            ind_percent = calc_percentage(
                                ind_value,
                                len_final_ind_eval_list,
                            ) / score['max']  #noqa
                        except ZeroDivisionError:
                            ind_percent = 0

                        ind_percent_sum = ind_percent_sum + ind_percent
                        str_percent = str(
                            ind_percent
                            )[:4] if len(str(
                                ind_percent
                                )) > 4 else str(ind_percent)

                        final_indicator_list.append({
                            'object': {
                                'name': indicator.name,
                                'description': indicator.description,
                            },
                            'value': ind_value,
                            'str_percent': str_percent,
                            'percent': ind_percent,
                            'is_evaluated': is_evaluated,
                        })

                    # Creando dicionario para luego serializar como json.
                    try:
                        str_percent = (str(
                            ind_percent_sum / indicator_evaluated)[:4]) if len(str(ind_percent_sum / indicator_evaluated)) > 4 else str(ind_percent_sum / indicator_evaluated)  #noqa
                        percent = ind_percent_sum / indicator_evaluated
                    except ZeroDivisionError:
                        str_percent = 0
                        percent = 0

                    final_skill_list.append({
                        'object': {
                            'name': skill.name,
                            'description': skill.description,
                        },
                        'str_percent': str_percent,
                        'percent': percent,
                        'value': skill_value,
                        'indicator_list': final_indicator_list,
                        'evaluated_at_least_once': evaluated_at_least_once,
                    })

                context['skill_list'] = final_skill_list
                context['json_skill_list'] = json.dumps(final_skill_list)

            if has_profile(context['current_profile'], 'admin'):
                context['courses'] = obj

        return context


class ProgramIndexView(LoginRequiredMixin, DetailView):
    """Program Index."""
    model = Program
    slug_field = 'code'
    template_name = 'core/program_index.html'

    def get_object(self):
        """Get obj."""
        program = get_object_or_404(Program, code=self.kwargs['code'])
        return program

    def get_context_data(self, **kwargs):
        """Get ctx."""
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']

        context['program'] = Program.objects.get(code=self.kwargs['code'])
        user = self.request.user

        context = get_context_current_profile(context, self)

        if context['current_profile']:
            if has_profile(context['current_profile'], 'teacher'):
                context['courses'] = Course.objects.filter(
                    teachers=user,
                    subject__subjects_group__program=self.get_object())

            if has_profile(context['current_profile'], 'student'):
                context['courses'] = Course.objects.filter(
                    students=user,
                    subject__subjects_group__program=self.get_object())

            if has_profile(context['current_profile'], 'admin'):
                context['courses'] = Course.objects.filter(
                    subject__subjects_group__program=self.get_object())

        return context


class CourseView(LoginRequiredMixin, DetailView):
    model = Course
    template_name = 'core/course.html'

    def get_context_data(self, **kwargs):
        """Get ctx."""

        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']

        context = get_context_current_profile(context, self)

        context['score'] = get_score()
        context['program'] = Program.objects.get(code=self.kwargs['code'])

        students = student_list_with_indicator(self.kwargs['pk'])
        context['total_half_percent'] = students['total_half_percent']
        context['total_indicators'] = students['total_indicators']
        context['students_with_indicator'] = students[
            'students_with_indicator']

        return context


class EvaluatedIndexEvaluatorView(LoginRequiredMixin, DetailView):
    model = User
    template_name = 'core/evaluated_evaluator_index.html'

    def get_context_data(self, **kwargs):
        """Get ctx."""
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']
        context['program'] = Program.objects.get(code=self.kwargs['code'])
        context['course'] = Course.objects.get(pk=self.kwargs['course_id'])
        context['score'] = get_score()
        context['evaluated'] = evaluated_with_indicator(
            self.kwargs['course_id'], self.get_object())
        context['feedback_list'] = Feedback.objects.filter(
            course=context['course'],
            evaluated=self.get_object().pk,
        ).all()

        context = get_context_current_profile(context, self)

        return context


class EvaluatedIndexView(LoginRequiredMixin, DetailView):
    model = User
    template_name = 'core/evaluated_index.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']
        context['program'] = Program.objects.get(code=self.kwargs['code'])
        context['course'] = Course.objects.get(pk=self.kwargs['course_id'])
        context['score'] = get_score()
        context['evaluated'] = evaluated_with_indicator(
            self.kwargs['course_id'], self.get_object())
        context['feedback_list'] = Feedback.objects.filter(
            course=context['course'],
            evaluated=self.request.user.id,
        ).all()

        context = get_context_current_profile(context, self)

        return context
