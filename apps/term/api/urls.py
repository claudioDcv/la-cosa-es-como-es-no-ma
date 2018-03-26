from django.conf.urls import url, include
from apps.term.api.views import FeedbackViewSet, FinalIndicatorEvaluationViewSet
from apps.base.api.views import StudentViewSet

from rest_framework import routers


router = routers.DefaultRouter()

router.register(r'student', StudentViewSet)

router.register(r'feedback', FeedbackViewSet)
router.register(r'final-indicator-evaluation', FinalIndicatorEvaluationViewSet)


urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
