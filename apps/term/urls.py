from django.conf.urls import url, include
from apps.term.models import FinalIndicatorEvaluation, Feedback
from rest_framework import routers, serializers, viewsets


class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = Feedback
        fields = '__all__'


class FeedbackViewSet(viewsets.ModelViewSet):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer


router = routers.DefaultRouter()
router.register(r'feedback', FeedbackViewSet)


class FinalIndicatorEvaluationSerializer(serializers.ModelSerializer):
    class Meta:
        model = FinalIndicatorEvaluation
        fields = '__all__'


class FinalIndicatorEvaluationViewSet(viewsets.ModelViewSet):
    queryset = FinalIndicatorEvaluation.objects.all()
    serializer_class = FinalIndicatorEvaluationSerializer


router.register(r'final-indicator-evaluation', FinalIndicatorEvaluationViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
