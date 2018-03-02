from django.views.generic.detail import DetailView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import get_object_or_404
from apps.base.views import get_context_current_profile

from apps.core.models import Program
from apps.term.models import Course
from apps.base.models import Profile


def is_profile(current_profile, profile):
    current_profile_name = ''
    for prof in current_profile.ROLE_CHOICES:
        if prof[0] == current_profile.id:
            current_profile_name = prof[1]
    return current_profile_name == profile


class ProgramIndexView(LoginRequiredMixin, DetailView):
    model = Program
    slug_field = 'code'
    template_name = "core/program_index.html"

    def get_object(self):
        program = get_object_or_404(Program, code=self.kwargs['code'])
        return program

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user = self.request.user

        context = get_context_current_profile(context, self)

        if is_profile(context['current_profile'], 'teachers'):
            courses_teachers = Course.objects.filter(teachers=user, subject__subjects_group__program=self.get_object())
            context['courses'] = courses_teachers

        if is_profile(context['current_profile'], 'student'):
            courses_student = Course.objects.filter(students=user, subject__subjects_group__program=self.get_object())
            context['courses'] = courses_student

        if is_profile(context['current_profile'], 'admin'):
            courses_student = Course.objects.filter(subject__subjects_group__program=self.get_object())
            context['courses'] = courses_student

        return context
