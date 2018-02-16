from django.db import models
from django.contrib.postgres.fields import JSONField
from apps.base.models import SoftDeleteTSModel, DescriptiveModel, User


class Action(SoftDeleteTSModel, DescriptiveModel):
    checksum = models.CharField(blank=True, max_length=100)

    class Meta:
         verbose_name = 'tipo de acción para log'


class Log(SoftDeleteTSModel):
    url = models.CharField(max_length=250, verbose_name='URL')
    data = JSONField(blank=True, null=True,)
    action = models.ForeignKey(
        Action,
        on_delete=models.CASCADE,
        verbose_name='acción',
    )
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        verbose_name='usuario',
    )
