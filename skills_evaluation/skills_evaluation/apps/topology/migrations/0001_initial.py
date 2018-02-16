# Generated by Django 2.0.2 on 2018-02-16 00:45

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Node',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_deleted', models.BooleanField(default=False)),
                ('created_ts', models.DateTimeField(auto_now_add=True)),
                ('updated_ts', models.DateTimeField(auto_now=True)),
                ('name', models.CharField(max_length=250, verbose_name='nombre')),
                ('code', models.CharField(max_length=100, unique=True, verbose_name='código')),
                ('description', models.TextField(blank=True, verbose_name='descripción')),
            ],
            options={
                'verbose_name': 'nodo',
            },
        ),
        migrations.CreateModel(
            name='NodeType',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_deleted', models.BooleanField(default=False)),
                ('created_ts', models.DateTimeField(auto_now_add=True)),
                ('updated_ts', models.DateTimeField(auto_now=True)),
                ('name', models.CharField(max_length=250, verbose_name='nombre')),
                ('code', models.CharField(max_length=100, unique=True, verbose_name='código')),
                ('description', models.TextField(blank=True, verbose_name='descripción')),
                ('is_top', models.BooleanField(default=False)),
                ('can_have_programs', models.BooleanField(default=False)),
            ],
            options={
                'verbose_name': 'tipo de nodo',
            },
        ),
        migrations.CreateModel(
            name='NodeTypeParent',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_deleted', models.BooleanField(default=False)),
                ('created_ts', models.DateTimeField(auto_now_add=True)),
                ('updated_ts', models.DateTimeField(auto_now=True)),
                ('node_type', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='topology.NodeType', verbose_name='tipo de nodo')),
                ('parent_type', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='parent_type', to='topology.NodeType', verbose_name='tipo de padre')),
            ],
            options={
                'verbose_name': 'tipo de nodo padre',
            },
        ),
        migrations.AddField(
            model_name='node',
            name='node_type',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='topology.NodeType', verbose_name='tipo de nodo'),
        ),
        migrations.AddField(
            model_name='node',
            name='parent',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='topology.Node', verbose_name='nodo padre'),
        ),
    ]
