
from django.urls import path
from apps.maintainer.views import StudentListView, StudentUpdate, StudentMasiveInsertView


urlpatterns = [
    path('program/<slug:code>/<profile>/student-list', StudentListView.as_view(), name='student-list'),
    path('program/<slug:code>/<profile>/student-list/<int:pk>', StudentUpdate.as_view(), name='student-update'),
    path('program/<slug:code>/<profile>/student-masive-insert', StudentMasiveInsertView.as_view(), name='student-masive-insert'),
]
