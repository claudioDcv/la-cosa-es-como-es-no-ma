from django.contrib import admin
from .models import Course, FinalNoteEvaluation, TempNoteEvaluation, FinalIndicatorEvaluation, TempFinalIndicatorEvaluation


@admin.register(Course)
class CourseAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(FinalNoteEvaluation)
class FinalNoteEvaluationAdmin(admin.ModelAdmin):

    list_display = ('id',)
    search_fields = ('name',)


@admin.register(TempNoteEvaluation)
class TempNoteEvaluationAdmin(admin.ModelAdmin):

    list_display = ('id',)
    search_fields = ('name',)


@admin.register(FinalIndicatorEvaluation)
class FinalIndicatorEvaluationAdmin(admin.ModelAdmin):

    list_display = ('id',)
    search_fields = ('name',)


@admin.register(TempFinalIndicatorEvaluation)
class TempFinalIndicatorEvaluationAdmin(admin.ModelAdmin):

    list_display = ('id',)
    search_fields = ('name',)
