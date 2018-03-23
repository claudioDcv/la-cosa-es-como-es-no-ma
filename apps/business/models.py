from django.db import models
from apps.base.models import SoftDeleteTSModel, DescriptiveModel
from apps.core.models import Indicator, Program


class Survey(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    indicator = models.ManyToManyField(Indicator)

    class Meta:
        verbose_name = 'encuesta'


class Period(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    start_date = models.DateField()
    end_date = models.DateField()
    program = models.ForeignKey(Program, on_delete=models.CASCADE,)

    class Meta:
        verbose_name = 'periodo'

    def __str__(self):
        return '{0} {1}'.format(self.name, self.program)


class Campus(SoftDeleteTSModel, DescriptiveModel):
    program = models.ManyToManyField(Program)

    class Meta:
        verbose_name = 'campus'
        verbose_name_plural = 'campus'
