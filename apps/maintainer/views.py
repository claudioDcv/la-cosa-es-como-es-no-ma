from django.views.generic import TemplateView
from django.views.generic.list import ListView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.paginator import Paginator
from apps.base.models import User
from apps.base.views import get_context_current_profile
from apps.base.models import Profile, UserProfilesProgram
from apps.core.models import Program
from django.http import Http404

from django_tables2 import SingleTableView
import django_tables2 as tables
from django.utils.html import format_html
from django_tables2.utils import A  # alias for Accessor


class PersonTable(tables.Table):

    editar = tables.Column(accessor='id', verbose_name='Editar.')
    def render_editar(self, value):
        return format_html('<a class="btn btn-success btn-sm" href="#">Editar{0}</a>'.format(value))

    class Meta:
        fields = ('id', 'username', 'first_name', 'last_name', 'editar')
        model = User


class StudentListView(SingleTableView):
    model = User
    table_class = PersonTable
    template_name = 'maintainer/student-list.html'
    paginate_by = 15
    prev_next_item = 3

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        
        paginator = self.get_paginator(self.get_queryset(), self.paginate_by)
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
        
        context['q'] = self.request.GET.get('sort', '')
        context['page_range'] = page_range

        return context

    def get_queryset(self):
        return User.objects.filter(user_profiles_program__profiles='student')  # Default: Model.objects.all()