from django.contrib.auth.models import AbstractUser
from django.db import models

class UserProfile(AbstractUser):
    bio = models.TextField(blank=True, null=True)
    profile_picture = models.ImageField('profile_pictures/', blank=True, null=True)
    study_hours = models.PositiveIntegerField(default=0)
    streak_days = models.PositiveIntegerField(default=0)
    