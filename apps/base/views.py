import os

from django.views.generic import TemplateView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.detail import DetailView

from django.http import HttpResponseForbidden
from django.contrib import messages
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.forms import PasswordChangeForm
from django.shortcuts import render, redirect

from apps.base.models import Profile, User, UserProfilesProgram
from apps.core.models import Program
from apps.base.forms import ImageUploadForm


def get_context_current_profile(context, _self):
    context['has_profile'] = False
    try:
        context['current_profile'] = Profile.objects.get(
            code=_self.kwargs['profile'])
    except Profile.DoesNotExist:
        context['current_profile'] = False
    try:
        if context['current_profile']:

            _self.request.user.user_profiles_program.get(
                profiles=context['current_profile'].code,
                program=Program.objects.get(code=context['code']),
            )
            context['has_profile'] = True
    except Exception:
        context['has_profile'] = False
    return context


class IndexView(TemplateView):
    template_name = "base/index.html"

    def render_to_response(self, context, **response_kwargs):
        if self.request.user.is_authenticated:
            return redirect('home')
        return redirect('login')


class HomeView(LoginRequiredMixin, TemplateView):
    template_name = "base/home.html"

    def get(self, request, **kwargs):
        student_profile = User.objects.filter(
            id=self.request.user.id,
            user_profiles_program__profiles='student',
        )

        if len(student_profile) == 1:
            prof = student_profile.first()
            programs = prof.user_profiles_program.all()
            if len(programs) == 1:
                program = programs.first()
                code = program.program.code
                return redirect('/program/{0}/student/skill-list'.format(code))

        return super(HomeView, self).get(request, kwargs)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['user'] = self.request.user
        return context


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


def upload_pic(request):
    if request.method == 'POST':
        form = ImageUploadForm(request.POST, request.FILES)
        if form.is_valid():
            m = User.objects.get(pk=request.user.id)

            has_old_image = False
            if m.image_profile:
                has_old_image = True
                path = m.image_profile.path
            m.image_profile = form.cleaned_data['image_profile']
            m.save()

            if has_old_image:
                if os.path.isfile(path):
                    os.remove(path)

            messages.info(request, 'Imagen guadada con exito!')
            return redirect('self-user-detail')
    return HttpResponseForbidden('allowed only via POST')


def change_password(request):
    if request.method == 'POST':
        form = PasswordChangeForm(request.user, request.POST)
        if form.is_valid():
            user = form.save()
            update_session_auth_hash(request, user)  # Important!
            messages.success(request, 'Contraseña actualizada con exito!')
            return redirect('self-user-detail')
        else:
            messages.error(request, 'Primero debe corregir los errores.')
    else:
        form = PasswordChangeForm(request.user)
    return render(request, 'accounts/change_password.html', {
        'form': form
    })
