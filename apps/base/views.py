from django.views.generic import TemplateView
from django.contrib.auth.mixins import LoginRequiredMixin
from apps.base.models import Profile
from apps.core.models import Program


def get_context_current_profile(context, _self):
    context['has_profile'] = False
    try:
        context['current_profile'] = Profile.objects.get(id=_self.kwargs['profile'])
    except Profile.DoesNotExist as e:
        context['current_profile'] = False
    try:
        if context['current_profile']:
            _self.request.user.user_profiles_program.get(
                profiles=context['current_profile'].id,
                program=Program.objects.get(code=context['code']),
            )
            context['has_profile'] = True
    except Profile.DoesNotExist as e:
        context['has_profile'] = False
    return context


class IndexView(TemplateView):
    template_name = "base/index.html"


class HomeView(LoginRequiredMixin, TemplateView):
    template_name = "base/home.html"
