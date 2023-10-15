from django.urls import path
from . import views

urlpatterns = [
    path('study_topics/', views.get_study_topics, name='get_study_topics'),
    path('study_topics/add/', views.add_study_topics, name='add_study_topics'),
    path('study_topics/update/<int:topic_id>/', views.update_study_topic, name='update_study_topic'),
    path('study_topics/delete/<int:topic_id>/', views.delete_study_topic, name='delete_study_topic'),
    path('study_topics/review_topics/', views.get_review_topics, name='get_review_topics'),
]
