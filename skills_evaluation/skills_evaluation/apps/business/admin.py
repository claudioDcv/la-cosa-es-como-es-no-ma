from django.contrib import admin
from .models import Survey, Period, Campus


@admin.register(Survey)
class SurveyAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(Period)
class PeriodAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(Campus)
class CampusAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)
