from django.contrib import admin
from .models import Course, FinalScoreEvaluation, TempScoreEvaluation, FinalIndicatorEvaluation, TempFinalIndicatorEvaluation


@admin.register(Course)
class CourseAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(FinalScoreEvaluation)
class FinalScoreEvaluationAdmin(admin.ModelAdmin):

    list_display = ('id',)
    search_fields = ('name',)


@admin.register(TempScoreEvaluation)
class TempScoreEvaluationAdmin(admin.ModelAdmin):

    list_display = ('id',)
    search_fields = ('name',)


@admin.register(FinalIndicatorEvaluation)
class FinalIndicatorEvaluationAdmin(admin.ModelAdmin):

    list_display = ('id', 'evaluator', 'evaluated', 'course', 'indicator')
    search_fields = ('name',)


@admin.register(TempFinalIndicatorEvaluation)
class TempFinalIndicatorEvaluationAdmin(admin.ModelAdmin):

    list_display = ('id',)
    search_fields = ('name',)
