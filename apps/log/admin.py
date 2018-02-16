from django.contrib import admin
from .models import Action, Log


@admin.register(Action)
class ActionAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(Log)
class LogAdmin(admin.ModelAdmin):

    list_display = ('id', 'url',)
    search_fields = ('url',)
