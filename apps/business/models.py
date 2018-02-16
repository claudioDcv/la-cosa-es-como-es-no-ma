from django.db import models
from apps.base.models import SoftDeleteTSModel, DescriptiveModel
from apps.core.models import Indicator, Program


class Survey(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    indicator = models.ManyToManyField(Indicator)


class Period(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    start_date = models.DateField()
    end_date = models.DateField()
    program = models.ForeignKey(Program, on_delete=models.CASCADE,)


class Campus(SoftDeleteTSModel, DescriptiveModel):
    program = models.ManyToManyField(Program)
