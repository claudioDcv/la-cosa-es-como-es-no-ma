from django.views.generic import TemplateView
from django.views.generic.list import ListView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.paginator import Paginator
from apps.base.models import User
from apps.base.views import get_context_current_profile
from apps.base.models import Profile, UserProfilesProgram
from apps.core.models import Program
from django.http import Http404


class StudentListView(LoginRequiredMixin, ListView):

    model = User
    template_name = 'maintainer/student-list.html'  # Default: <app_label>/<model_name>_list.html
    # context_object_name = 'users'  # Default: object_list
    paginate_by = 15
    queryset = User.objects.filter(user_profiles_program__profiles='student')  # Default: Model.objects.all()

    prev_next_item = 6

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']
        context = get_context_current_profile(context, self)
        context['program'] = Program.objects.get(code=self.kwargs['code'])

        has_admin = UserProfilesProgram.objects.filter(
                user=self.request.user,
                profiles__code=Profile.ADMIN,
                program=context['program'],
            ).count() > 0
        
        if has_admin:

            self.queryset = self.queryset.filter(user_profiles_program__program=context['program'])
            paginator = self.get_paginator(self.queryset, self.paginate_by)
            try:
                page = int(self.request.GET.get('page', '1'))
            except:
                page = 1

            try:
                blogs = paginator.page(page)
            except Exception as _:
                blogs = paginator.page(1)

            # Get the index of the current page
            index = blogs.number - 1  # edited to something easier without index
            # This value is maximum index of your pages, so the last page - 1
            max_index = len(paginator.page_range)
            # You want a range of 7, so lets calculate where to slice the list
            start_index = index - self.prev_next_item if index >= self.prev_next_item else 0
            end_index = index + self.prev_next_item if index <= max_index - self.prev_next_item else max_index
            # Get our new page range. In the latest versions of Django page_range returns 
            # an iterator. Thus pass it to list, to make our slice possible again.
            page_range = list(paginator.page_range)[start_index:end_index]
            
            context['page_range'] = page_range
            return context
        else:
            raise Http404("Does not exist")
