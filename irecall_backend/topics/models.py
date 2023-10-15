from django.db import models
from users.models import UserProfile

class StudyTopic(models.Model):
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE, related_name='study_topics')
    name = models.CharField(max_length=255)
    description = models.TextField(null=True, blank=True)
    date_added = models.DateTimeField(auto_now_add=True)
    review_1day = models.DateTimeField(null=True, blank=True)
    review_3days = models.DateTimeField(null=True, blank=True)
    review_1week = models.DateTimeField(null=True, blank=True)
    review_1month = models.DateTimeField(null=True, blank=True)
    review_3months = models.DateTimeField(null=True, blank=True)
    
    def __str__(self):
        return self.name
