from django.db import models
from apps.base.models import SoftDeleteTSModel


class NodeType(SoftDeleteTSModel):
    name = models.CharField(max_length=250, verbose_name='nombre')
    code = models.CharField(max_length=100, verbose_name='código', unique=True)
    description = models.TextField(blank=True, verbose_name='descripción')
    is_top = models.BooleanField(default=False)
    can_have_programs = models.BooleanField(default=False)

    def __str__ (self):
        return '{0} ({1})'.format(self.name, self.code)

    class Meta:
         verbose_name = 'tipo de nodo'


class NodeTypeParent(SoftDeleteTSModel):
    node_type = models.ForeignKey(
        NodeType,
        on_delete=models.CASCADE,
        verbose_name='tipo de nodo',
    )

    parent_type = models.ForeignKey(
        NodeType,
        on_delete=models.CASCADE,
        verbose_name='tipo de padre',
        related_name='parent_type',
    )

    class Meta:
         verbose_name = 'tipo de nodo padre'


class Node(SoftDeleteTSModel):
    name = models.CharField(max_length=250, verbose_name='nombre')
    code = models.CharField(max_length=100, verbose_name='código', unique=True)
    description = models.TextField(blank=True, verbose_name='descripción')

    node_type = models.ForeignKey(
        NodeType,
        on_delete=models.CASCADE,
        verbose_name='tipo de nodo',
    )

    parent = models.ForeignKey(
        'self',
        blank=True,
        null=True,
        on_delete=models.CASCADE,
        verbose_name='nodo padre',
    )

    def __str__(self):
        parent = ' < {0}'.format(self.parent) if self.parent is not None else ''
        return '{0} {1}'.format(self.code, parent)

    class Meta:
         verbose_name = 'nodo'
