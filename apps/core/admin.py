from django.contrib import admin
from .models import Indicator, Subject, Level, SubjectsGroup,\
    Skill, SkillsGroup, Program, SkillLevelDescription


@admin.register(Indicator)
class IndicatorAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(Subject)
class SubjectAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(Level)
class LevelAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(SubjectsGroup)
class SubjectsGroupAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(Skill)
class SkillAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(SkillsGroup)
class SkillsGroupAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(Program)
class ProgramAdmin(admin.ModelAdmin):

    list_display = ('id', 'code', 'name')
    search_fields = ('name',)


@admin.register(SkillLevelDescription)
class SkillLevelDescriptionAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)
