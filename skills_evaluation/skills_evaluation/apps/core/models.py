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


class Skill(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    skill_group = models.ForeignKey(
        SkillsGroup,
        on_delete=models.CASCADE,
    )


class SubjectsGroup(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    program = models.ForeignKey(
        Program,
        on_delete=models.CASCADE,
    )


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
