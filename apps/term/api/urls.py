from django.conf.urls import include
from django.conf.urls import url

from apps.term.api.views import CourseViewSet
from apps.term.api.views import FeedbackViewSet
from apps.term.api.views import FinalIndicatorEvaluationViewSet
from apps.base.api.views import StudentViewSet

from rest_framework import routers


router = routers.DefaultRouter()

router.register(r'course', CourseViewSet)
router.register(r'feedback', FeedbackViewSet)
router.register(r'final-indicator-evaluation', FinalIndicatorEvaluationViewSet)
router.register(r'student', StudentViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
