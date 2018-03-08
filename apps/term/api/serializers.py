from django.conf.urls import url, include
from apps.term.models import FinalIndicatorEvaluation, Feedback
from rest_framework import serializers


class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = Feedback
        fields = '__all__'


class FinalIndicatorEvaluationSerializer(serializers.ModelSerializer):
    class Meta:
        model = FinalIndicatorEvaluation
        fields = '__all__'
