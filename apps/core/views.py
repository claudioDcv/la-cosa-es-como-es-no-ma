from django.views.generic.detail import DetailView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import get_object_or_404
from apps.base.views import get_context_current_profile
from django.http import Http404

from apps.core.models import Program
from apps.term.models import Course, Feedback
from apps.base.models import Profile, User
from apps.base.helpers import get_score, student_list_with_indicator, evaluated_with_indicator


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


class ProgramIndexView(LoginRequiredMixin, DetailView):
    model = Program
    slug_field = 'code'
    template_name = "core/program_index.html"

    def get_object(self):
        program = get_object_or_404(Program, code=self.kwargs['code'])
        return program

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']

        context['program'] = Program.objects.get(code=self.kwargs['code'])
        user = self.request.user

        context = get_context_current_profile(context, self)

        if context['current_profile']:
            if has_profile(context['current_profile'], 'teacher'):
                context['courses'] = Course.objects.filter(teachers=user, subject__subjects_group__program=self.get_object())

            if has_profile(context['current_profile'], 'student'):
                context['courses'] = Course.objects.filter(students=user, subject__subjects_group__program=self.get_object())

            if has_profile(context['current_profile'], 'admin'):
                context['courses'] = Course.objects.filter(subject__subjects_group__program=self.get_object())

        return context


class CourseView(LoginRequiredMixin, DetailView):
    model = Course
    template_name = "core/course.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']

        context = get_context_current_profile(context, self)

        context['score'] = get_score()
        context['program'] = Program.objects.get(code=self.kwargs['code'])

        students = student_list_with_indicator(self.kwargs['pk'])
        context['total_half_percent'] = students['total_half_percent']
        context['total_indicators'] = students['total_indicators']
        context['students_with_indicator'] = students['students_with_indicator']

        return context


class EvaluatedIndexEvaluatorView(LoginRequiredMixin, DetailView):
    model = User
    template_name = "core/evaluated_evaluator_index.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']
        context['program'] = Program.objects.get(code=self.kwargs['code'])
        context['course'] = Course.objects.get(pk=self.kwargs['course_id'])
        context['score'] = get_score()
        context['evaluated'] = evaluated_with_indicator(self.kwargs['course_id'], self.get_object())
        context['feedback_list'] = Feedback.objects.filter(
            course=context['course'],
            evaluated=self.get_object().pk,
        ).all()

        context = get_context_current_profile(context, self)

        return context


class EvaluatedIndexView(LoginRequiredMixin, DetailView):
    model = User
    template_name = "core/evaluated_index.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']
        context['program'] = Program.objects.get(code=self.kwargs['code'])
        context['course'] = Course.objects.get(pk=self.kwargs['course_id'])
        context['score'] = get_score()
        context['evaluated'] = evaluated_with_indicator(self.kwargs['course_id'], self.get_object())
        context['feedback_list'] = Feedback.objects.filter(
            course=context['course'],
            evaluated=self.request.user.id,
        ).all()

        context = get_context_current_profile(context, self)

        return context
