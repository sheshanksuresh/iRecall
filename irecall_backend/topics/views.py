from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from django.db.models import Q
from datetime import datetime, timedelta
from .models import StudyTopic
from .serializers import StudyTopicSerializer

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_study_topics(request):
    topics = StudyTopic.objects.filter(user=request.user)
    serializer = StudyTopicSerializer(topics, many=True)
    return Response(serializer.data)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def add_study_topics(request):
    serializer = StudyTopicSerializer(data=request.data)
    if serializer.is_valid():
        instance = serializer.save(user=request.user)
        now = datetime.now()
        instance.review_1day = now + timedelta(days=1)
        instance.review_3days = now + timedelta(days=3)
        instance.review_1week = now + timedelta(weeks=1)
        instance.review_1month = now + timedelta(weeks=4)
        instance.review_3months = now + timedelta(weeks=12)
        instance.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def update_study_topic(request, topic_id):
    try:
        topic = StudyTopic.objects.get(id=topic_id, user=request.user)
    except StudyTopic.DoesNotExist:
        return Response({'message': 'Topic not found'}, status=status.HTTP_404_NOT_FOUND)
    
    serializer = StudyTopicSerializer(topic, data=request.data, partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def delete_study_topic(request, topic_id):
    try:
        topic = StudyTopic.objects.get(id=topic_id, user=request.user)
    except StudyTopic.DoesNotExist:
        return Response({'message': 'Topic not found'}, status=status.HTTP_404_NOT_FOUND)
    
    topic.delete()
    return Response({'message': 'Topic deleted'}, status=status.HTTP_200_OK)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_review_topics(request):
    now = datetime.now()
    topics_due = StudyTopic.objects.filter(
        Q(review_1day__lte=now) |
        Q(review_3days__lte=now) |
        Q(review_1week__lte=now) |
        Q(review_1month__lte=now) |
        Q(review_3months__lte=now),
        user=request.user
    )
    serializer = StudyTopicSerializer(topics_due, many=True)
    return Response(serializer.data)
