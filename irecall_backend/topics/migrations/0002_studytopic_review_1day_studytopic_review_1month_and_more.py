# Generated by Django 4.2.6 on 2023-10-15 01:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("topics", "0001_initial"),
    ]

    operations = [
        migrations.AddField(
            model_name="studytopic",
            name="review_1day",
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name="studytopic",
            name="review_1month",
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name="studytopic",
            name="review_1week",
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name="studytopic",
            name="review_3days",
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name="studytopic",
            name="review_3months",
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
