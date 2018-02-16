from django.contrib import admin
from .models import Node, NodeType, NodeTypeParent


@admin.register(Node)
class NodeAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(NodeType)
class NodeTypeAdmin(admin.ModelAdmin):

    list_display = ('id', 'name',)
    search_fields = ('name',)


@admin.register(NodeTypeParent)
class NodeTypeParentAdmin(admin.ModelAdmin):
    pass
