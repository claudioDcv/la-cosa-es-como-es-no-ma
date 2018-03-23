from django.contrib import admin
from .models import Survey, Period, Campus


@admin.register(Survey)
class SurveyAdmin(admin.ModelAdmin):

    list_display = ('id', 'name', 'code')
    search_fields = ('name', 'code')


@admin.register(Period)
class PeriodAdmin(admin.ModelAdmin):

    list_display = ('id', 'name', 'program', 'start_date', 'end_date')
    search_fields = ('name', 'start_date', 'end_date')


@admin.register(Campus)
class CampusAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)
