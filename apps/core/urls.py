from django.urls import path
from apps.core.views import ProgramIndexView

urlpatterns = [
    path('program/<slug:code>/<profile>', ProgramIndexView.as_view(), name='program-index'),
]
