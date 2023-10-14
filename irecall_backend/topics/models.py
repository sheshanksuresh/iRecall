from django.db import models
from users.models import UserProfile

class StudyTopic(models.Model):
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE, related_name='study_topics')
    name = models.CharField(max_length=255)
    description = models.TextField(null=True, blank=True)
    date_added = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.name
