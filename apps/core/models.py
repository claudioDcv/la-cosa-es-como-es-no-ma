from django.db import models
from apps.base.models import SoftDeleteTSModel, DescriptiveModel
from apps.topology.models import Node


class Program(SoftDeleteTSModel, DescriptiveModel):
    node = models.ForeignKey(
        Node,
        on_delete=models.CASCADE,
    )

    class Meta:
        verbose_name = 'programa'


class SkillsGroup(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    program = models.ForeignKey(
        Program,
        on_delete=models.CASCADE,
    )

    class Meta:
        verbose_name = 'grupo de competencias'
        verbose_name_plural = 'grupos de competencias'


class Skill(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    skill_group = models.ForeignKey(
        SkillsGroup,
        on_delete=models.CASCADE,
    )

    class Meta:
        verbose_name = 'competencia'


class SubjectsGroup(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    program = models.ForeignKey(
        Program,
        on_delete=models.CASCADE,
    )

    class Meta:
        verbose_name = 'grupo de asignaturas'
        verbose_name_plural = 'grupos de asignaturas'


class Level(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)

    program = models.ForeignKey(
        Program,
        on_delete=models.CASCADE,
    )

    class Meta:
        verbose_name = 'nivel'
        verbose_name_plural = 'niveles'


class Subject(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    subjects_group = models.ForeignKey(
        SubjectsGroup,
        on_delete=models.CASCADE,
    )
    level = models.ForeignKey(
        Level,
        on_delete=models.CASCADE,
    )

    class Meta:
        verbose_name = 'asignatura'


class Indicator(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    subject = models.ForeignKey(
        Subject,
        on_delete=models.CASCADE,
    )
    skill = models.ForeignKey(
        Skill,
        on_delete=models.CASCADE,
    )

    class Meta:
        verbose_name = 'indicador'
        verbose_name_plural = 'indicadores'


class SkillLevelDescription(SoftDeleteTSModel, DescriptiveModel):
    level = models.ForeignKey(
        Level,
        on_delete=models.CASCADE,
    )
    skill = models.ForeignKey(
        Skill,
        on_delete=models.CASCADE,
    )

    class Meta:
        verbose_name = 'descripción competencia y nivel'
        verbose_name_plural = 'descripciones competencias y niveles'
