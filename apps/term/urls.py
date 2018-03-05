from django.conf.urls import url, include
from apps.term.models import FinalIndicatorEvaluation
from rest_framework import routers, serializers, viewsets

# Serializers define the API representation.
class FinalIndicatorEvaluationSerializer(serializers.ModelSerializer):
    class Meta:
        model = FinalIndicatorEvaluation
        fields = '__all__'

# ViewSets define the view behavior.
class FinalIndicatorEvaluationViewSet(viewsets.ModelViewSet):
    queryset = FinalIndicatorEvaluation.objects.all()
    serializer_class = FinalIndicatorEvaluationSerializer

# Routers provide an easy way of automatically determining the URL conf.
router = routers.DefaultRouter()
router.register(r'final-indicator-evaluation', FinalIndicatorEvaluationViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
