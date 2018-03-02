from django.urls import path
from apps.core.views import ProgramIndexView, CourseView

urlpatterns = [
    path('program/<slug:code>/<profile>', ProgramIndexView.as_view(), name='program-index'),
    path('program/<slug:code>/<profile>/course/<pk>', CourseView.as_view(), name='course-index'),
]
