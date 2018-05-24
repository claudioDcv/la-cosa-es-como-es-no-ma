from django.urls import path
from apps.core.views import ProgramIndexView, CourseView, EvaluatedIndexView, EvaluatedIndexEvaluatorView, SkillGroupIndexView

urlpatterns = [
    path('program/<slug:code>/<profile>/<int:period>', ProgramIndexView.as_view(), name='program-index'),

    path('program/<slug:code>/<profile>/period/<int:period>', ProgramIndexView.as_view(), name='program-index'),
    path('program/<slug:code>/<profile>/course/<pk>/period/<int:period>', CourseView.as_view(), name='course-index'),
    path('program/<slug:code>/<profile>/skill-list', SkillGroupIndexView.as_view(), name='skill-index'),
    path('program/<slug:code>/<profile>/course/<course_id>/evaluated/<pk>/period/<int:period>', EvaluatedIndexEvaluatorView.as_view(), name='evaluated-evaluator-index'),
    path('program/<slug:code>/<profile>/course/<course_id>/detail/period/<int:period>', EvaluatedIndexView.as_view(), name='evaluated-index'),
]
