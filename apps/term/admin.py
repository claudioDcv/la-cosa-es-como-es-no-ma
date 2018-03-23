from django.contrib import admin
from .models import Course, FinalScoreEvaluation, TempScoreEvaluation, FinalIndicatorEvaluation, TempFinalIndicatorEvaluation, Feedback
from apps.base.models import User


@admin.register(Course)
class CourseAdmin(admin.ModelAdmin):
    list_display = ('id', 'name',)
    search_fields = ('name',)

    def formfield_for_manytomany(self, db_field, request, **kwargs):
        if db_field.name == 'teachers':
            kwargs['queryset'] = User.objects.filter(user_profiles_program__profiles__code='teacher')
        if db_field.name == 'students':
            kwargs['queryset'] = User.objects.filter(user_profiles_program__profiles__code='student')
        return super(CourseAdmin, self).formfield_for_foreignkey(
            db_field, request, **kwargs
        )


@admin.register(Feedback)
class FeedbackAdmin(admin.ModelAdmin):
    list_display = ('id', 'evaluator', 'evaluated', 'course')
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
