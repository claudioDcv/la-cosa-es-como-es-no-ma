from django.urls import path
from apps.core.views import ProgramIndexView, CourseView, EvaluatedIndexView

urlpatterns = [
    path('program/<slug:code>/<profile>', ProgramIndexView.as_view(), name='program-index'),
    path('program/<slug:code>/<profile>/course/<pk>', CourseView.as_view(), name='course-index'),
    path('program/<slug:code>/<profile>/course/<course_id>/evaluated/<pk>', EvaluatedIndexView.as_view(), name='evaluated-index'),
]
