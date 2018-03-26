from django.db.models import Q

from rest_framework import routers, serializers, viewsets
from rest_framework import permissions
from rest_framework import decorators, filters
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend

from apps.base.models import User, Profile
from apps.term.models import FinalIndicatorEvaluation, Feedback
from apps.term.api.serializers import FeedbackSerializer, FinalIndicatorEvaluationSerializer

from apps.base.api.serializers import UserSerializer

from apps.base.api_helpers import response_401


class StudentViewSet(viewsets.ModelViewSet):
    queryset = User.objects.values_list('username', 'first_name').all()
    serializer_class = UserSerializer


    def list(self, request):
        code = request.query_params.get('program__code', None)
        name = request.query_params.get('name', None)

        if code == None and name == None:
            return response_401()

        if User.has_profile_program(user=request.user, program_code=code, profile_list=Profile.ADMIN):
            queryset = User.objects.filter(Q(first_name__icontains=name) | Q(username__icontains=name))
            serializer = self.serializer_class(queryset, many=True)
            return Response(serializer.data)


        elif User.has_profile_program(user=request.user, program_code=code, profile_list=Profile.TEACHER):
            queryset = User.objects.filter(Q(first_name__icontains=name) | Q(username__icontains=name))
            serializer = self.serializer_class(queryset, many=True)
            return Response(serializer.data)

        elif User.has_profile_program(user=request.user, program_code=code, profile_list=Profile.STUDENT):
            return response_401()

        return response_401()
