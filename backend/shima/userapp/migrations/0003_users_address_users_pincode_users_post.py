# Generated by Django 4.2.3 on 2023-07-24 14:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('userapp', '0002_leave_application'),
    ]

    operations = [
        migrations.AddField(
            model_name='users',
            name='address',
            field=models.CharField(max_length=350, null=True),
        ),
        migrations.AddField(
            model_name='users',
            name='pincode',
            field=models.CharField(max_length=10, null=True),
        ),
        migrations.AddField(
            model_name='users',
            name='post',
            field=models.CharField(max_length=100, null=True),
        ),
    ]
