from django.views.generic import TemplateView
from django.views.generic.list import ListView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.paginator import Paginator
from apps.base.models import User


class StudentListView(LoginRequiredMixin, ListView):

    model = User
    template_name = 'maintainer/student-list.html'  # Default: <app_label>/<model_name>_list.html
    # context_object_name = 'users'  # Default: object_list
    paginate_by = 10
    queryset = User.objects.filter(user_profiles_program__profiles='student')  # Default: Model.objects.all()

    '''
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        user_list = User.objects.filter(user_profiles_program__profiles='student')
        page = self.request.GET.get('page', 1)

        paginator = Paginator(user_list, 10)
        try:
            users = paginator.page(page)
        except PageNotAnInteger:
            users = paginator.page(1)
        except EmptyPage:
            users = paginator.page(paginator.num_pages)

        context['objects'] = users

        return context
    '''