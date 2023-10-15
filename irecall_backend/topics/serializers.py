from rest_framework import serializers
from .models import StudyTopic

class StudyTopicSerializer(serializers.ModelSerializer):
    class Meta:
        model = StudyTopic
        fields = ["id", "user", "name", "description", "date_added"]
    