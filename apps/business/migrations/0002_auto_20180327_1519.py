# Generated by Django 2.0.2 on 2018-03-27 18:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('business', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='campus',
            name='name',
            field=models.CharField(max_length=250, verbose_name='nombre'),
        ),
        migrations.AlterField(
            model_name='period',
            name='name',
            field=models.CharField(max_length=250, verbose_name='nombre'),
        ),
        migrations.AlterField(
            model_name='survey',
            name='name',
            field=models.CharField(max_length=250, verbose_name='nombre'),
        ),
    ]
