# Generated by Django 2.0.2 on 2018-03-06 04:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('term', '0003_auto_20180303_2001'),
    ]

    operations = [
        migrations.AlterField(
            model_name='finalindicatorevaluation',
            name='fedback_score',
            field=models.FloatField(blank=True),
        ),
    ]
