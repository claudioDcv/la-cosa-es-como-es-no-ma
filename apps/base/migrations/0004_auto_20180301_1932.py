# Generated by Django 2.0.2 on 2018-03-01 22:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0003_auto_20180301_0652'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='email',
            field=models.EmailField(default=1, max_length=70, unique=True),
            preserve_default=False,
        ),
    ]
