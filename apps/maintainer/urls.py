
from django.urls import path
from apps.maintainer.views import StudentListView


urlpatterns = [
    path('program/<slug:code>/<profile>/student-list', StudentListView.as_view(), name='student-list'),
]
