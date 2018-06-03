from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.paginator import Paginator
from django.db.models import Q
from django.http import Http404
from django.utils.html import format_html
from django.views.generic import TemplateView
from django.views.generic.edit import UpdateView
from django.views.generic.list import ListView

from apps.base.helpers import get_periods, pagineitor, csv_to_list
from apps.base.models import Profile, User, UserProfilesProgram
from apps.base.views import get_context_current_profile
from apps.core.models import Program

from django.http import HttpResponse
import json


class StudentListView(LoginRequiredMixin, TemplateView):
    template_name = 'maintainer/student-list.html'


    def get_context_data(self, **kwargs):
        user = self.request.user
        """Get ctx."""
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']
        context['program'] = Program.objects.get(code=self.kwargs['code'])
        period = get_periods(context['code']).get('now').first()
        context['period'] = period.id

        queryset = User.objects.filter(
            user_profiles_program__program__code=context['code'],
            user_profiles_program__profiles__code='student',
        )

        # Pagination and order sort
        try:
            page = int(self.request.GET.get('page', '1'))
        except:
            page = 1
        
        try:
            order_by = self.request.GET.get('order_by', 'id')
        except:
            order_by = 'id'
        
        try:
            q = self.request.GET.get('q', '')
        except:
            q = ''
        
        if order_by:
            queryset = queryset.order_by(*order_by.split(','))
        
        if order_by:
            queryset = queryset.filter(
                Q(first_name__icontains=q) |
                Q(last_name__icontains=q)
            )

        paginator = pagineitor(queryset, page)


        context['students'] = paginator['objects'].object_list
        context['paginator'] = paginator['objects']
        context['page_range'] = paginator['page_range']

        context['order_by'] = order_by
        context['q'] = q

        context['querystring'] = '?q={2}&page={0}&order_by={1}'.format(
            context['paginator'].number,
            order_by,
            q
        )
        context['querystring_order_by'] = '?q={1}&page={0}&order_by'.format(
            context['paginator'].number,
            q
        )
        context['querystring_page'] = '?q={1}&order_by={0}&page'.format(
            order_by,
            q
        )
        # End Pagination

        return context
    
class StudentUpdate(UpdateView):
    model = User
    fields = ['first_name', 'last_name', 'username']
    template_name = 'maintainer/student-update-form.html'


class StudentMasiveInsertView(LoginRequiredMixin, TemplateView):
    template_name = 'maintainer/student-masive-insert.html'


    def post(self, request, **kwargs):
        if request.POST and request.FILES:
            data = csv_to_list(request.FILES['csv_file'])
            return HttpResponse(json.dumps(data), content_type="application/json")
    

    def get_context_data(self, **kwargs):
        user = self.request.user
        """Get ctx."""
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']
        context['program'] = Program.objects.get(code=self.kwargs['code'])
        period = get_periods(context['code']).get('now').first()
        context['period'] = period.id

        if self.request.method == 'POST':
            self.post(self.request, kwargs)