from django.views.generic import TemplateView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.detail import DetailView

from apps.base.models import Profile, User, UserProfilesProgram
from apps.core.models import Program


def get_context_current_profile(context, _self):
    context['has_profile'] = False
    try:
        context['current_profile'] = Profile.objects.get(
            id=_self.kwargs['profile'])
    except Profile.DoesNotExist:
        context['current_profile'] = False
    try:
        if context['current_profile']:
            _self.request.user.user_profiles_program.get(
                profiles=context['current_profile'].id,
                program=Program.objects.get(code=context['code']),
            )
            context['has_profile'] = True
    except Profile.DoesNotExist:
        context['has_profile'] = False
    return context


class IndexView(TemplateView):
    template_name = "base/index.html"


class HomeView(LoginRequiredMixin, TemplateView):
    template_name = "base/home.html"


class UserDetailView(LoginRequiredMixin, DetailView):
    model = User
    template_name = "base/user-detail.html"

    def get_context_data(self, **kwargs):
        """
        return context data
        """
        context = super().get_context_data(**kwargs)
        context['user_profiles_programs'] = UserProfilesProgram.objects.filter(
            user=self.request.user)
        return context


class SelfUserDetailView(LoginRequiredMixin, TemplateView):
    template_name = "base/user-detail.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['object'] = User.objects.get(pk=self.request.user.pk)
        context['user_profiles_programs'] = UserProfilesProgram.objects.filter(
            user=self.request.user)

        return context
