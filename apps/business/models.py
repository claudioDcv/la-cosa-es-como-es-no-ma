from datetime import datetime

from django.db import models
from apps.base.models import SoftDeleteTSModel
from apps.base.models import DescriptiveModel
from apps.core.models import Indicator
from apps.core.models import Program
from apps.core.models import Subject


class Survey(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)
    indicator = models.ManyToManyField(Indicator)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE,)

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

    @property
    def is_active(self):
        start_date = self.start_date
        end_date = self.end_date
        now = datetime.now().date()
        return start_date <= now <= end_date


class Campus(SoftDeleteTSModel, DescriptiveModel):
    program = models.ManyToManyField(Program)

    class Meta:
        verbose_name = 'campus'
        verbose_name_plural = 'campus'
