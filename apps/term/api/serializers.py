from datetime import datetime
from collections import defaultdict

from rest_framework import serializers

from apps.term.models import Course
from apps.term.models import Feedback
from apps.term.models import FinalIndicatorEvaluation

## HARDCODED
MIN_INDICATOR_VALUE = 0
MAX_INDICATOR_VALUE = 3


class CourseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Course

        fields = (
            'id',
            'name',
            'code',
            'section',
            'period',
            'campus',
            'subject',
            'survey',
            'program',
            'teachers',
            'students',
            'active',
            'progress_level',
            'goal_level',
        )

    period = serializers.SerializerMethodField()
    campus = serializers.SerializerMethodField()
    subject = serializers.SerializerMethodField()
    survey = serializers.SerializerMethodField()
    program = serializers.SerializerMethodField()
    teachers = serializers.SerializerMethodField()
    students = serializers.SerializerMethodField()
    active = serializers.SerializerMethodField()
    progress_level = serializers.SerializerMethodField()
    goal_level = serializers.SerializerMethodField()

    def get_period(self, obj):
        return obj.period.name

    def get_campus(self, obj):
        return obj.campus.name

    def get_subject(self, obj):
        return obj.subject.name

    def get_survey(self, obj):
        return obj.survey.name

    def get_program(self, obj):
        return obj.period.program.name

    def get_teachers(self, obj):
        return [t.email for t in obj.teachers.order_by('email').all()]

    def get_students(self, obj):
        return [s.email for s in obj.students.order_by('email').all()]

    def get_active(self, obj):
        period = obj.period
        start_date = period.start_date
        end_date = period.end_date
        now = datetime.now().date()
        return start_date <= now <= end_date

    def get_progress_level(self, obj):
        students = obj.students.all()
        indicators = obj.survey.indicator.all()
        teachers = obj.teachers.all()

        len_total_values = len(students) * len(indicators) * len(teachers)

        total_evaluated_values = FinalIndicatorEvaluation.objects.filter(
            course=obj,
        ).values_list('value', flat=True)

        len_total_evaluated_values = len(total_evaluated_values)

        return float(len_total_evaluated_values)/len_total_values if len_total_values > 0 else None

    def get_goal_level(self, obj):
        total_evaluated_values = FinalIndicatorEvaluation.objects.filter(
            course=obj,
        ).values_list('value', flat=True)

        len_total_evaluated_values = len(total_evaluated_values)
        sum_total_evaluated_values = sum(total_evaluated_values)

        max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

        return float(sum_total_evaluated_values)/max_total_evaluated_values if max_total_evaluated_values > 0 else None


class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = Feedback
        fields = '__all__'


class FinalIndicatorEvaluationSerializer(serializers.ModelSerializer):
    class Meta:
        model = FinalIndicatorEvaluation
        fields = '__all__'

"""
    {
        "id": 2,
        "name": "COMPOSICIÓN Y COLOR",
        "description": "",
        "is_deleted": false,
        "created_ts": "2018-03-27T15:19:57.928000-03:00",
        "updated_ts": "2018-03-27T15:19:57.928000-03:00",
        "code": "AAC111",
        "section": "2",
        "checksum": "",
        "period": 1,
        "campus": 1,
        "subject": 1,
        "survey": 1,
        "teachers": [
            506
        ],
        "students": []
    },
"""