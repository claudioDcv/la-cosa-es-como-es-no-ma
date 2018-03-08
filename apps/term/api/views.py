from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from rest_framework import permissions
from rest_framework import decorators, filters
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend

from apps.base.models import User
from apps.term.models import FinalIndicatorEvaluation, Feedback
from apps.term.api.serializers import FeedbackSerializer, FinalIndicatorEvaluationSerializer

from apps.base.api_helpers import response_401


class CreateUpdateDeleteTeacherAdmin(permissions.BasePermission):

    def has_permission(self, request, view):
        if request.user.is_authenticated:
            if view.action in ('create', 'destroy', 'update'):
                return User.has_profile_program(
                    user=request.user,
                    program_code=request.data.get('code', ''),
                    profile_list=('teacher', 'admin'),
                )
            # import ipdb; ipdb.set_trace()
            return True
        else:
            return False


class FeedbackViewSet(viewsets.ModelViewSet):
    """
    ### create `admin|teacher`

    ### destroy `admin|teacher`

    ### update `admin|teacher`

    ### list `admin|teacher|student`
    > Muestra el `Feedback` de un `Course`

    - ordering
        - `id`
        - `score`
    - params
        - `course__subject__subjects_group__program__code`
            - str
            - required
            - example = arq
        - `course`
            - int
            - required
            - example = 1

    """
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter,)
    filter_fields = ('course', 'course__subject__subjects_group__program__code')
    ordering_fields = ('id', 'score')

    permission_classes = (CreateUpdateDeleteTeacherAdmin,)


    def list(self, request):
        code = request.query_params.get('course__subject__subjects_group__program__code', None)
        course = request.query_params.get('course', None)
        ordering = request.query_params.get('ordering', None)
        queryset = None

        if User.has_profile_program(user=request.user, program_code=code, profile_list=('admin'),):
            queryset = self.get_queryset().filter(course=course)

        elif User.has_profile_program(user=request.user, program_code=code, profile_list=('teacher'),):
            queryset = self.get_queryset().filter(course__teachers=request.user, course=course)

        elif User.has_profile_program(user=request.user, program_code=code, profile_list=('student'),):
            queryset = self.get_queryset().filter(evaluated=request.user, course=course)

        if ordering:
            queryset = queryset.order_by(ordering)

        serializer = self.serializer_class(queryset, many=True)
        return Response(serializer.data)


class FinalIndicatorEvaluationViewSet(viewsets.ModelViewSet):
    queryset = FinalIndicatorEvaluation.objects.all()
    serializer_class = FinalIndicatorEvaluationSerializer
