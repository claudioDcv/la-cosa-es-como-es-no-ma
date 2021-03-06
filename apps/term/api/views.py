from django_filters.rest_framework import DjangoFilterBackend
from django_filters import CharFilter
from django_filters import FilterSet
from rest_framework import filters
from rest_framework import permissions
from rest_framework import viewsets
from rest_framework.response import Response

from apps.base.models import User
from apps.term.api.serializers import CourseSerializer
from apps.term.api.serializers import FeedbackSerializer
from apps.term.api.serializers import FinalIndicatorEvaluationSerializer
from apps.core.models import Program
from apps.term.models import Course
from apps.term.models import Feedback
from apps.term.models import FinalIndicatorEvaluation


# permisos para feedback
class FeedBackCreateUpdateDeleteTeacherAdmin(permissions.BasePermission):

    def has_permission(self, request, view):
        if request.user.is_authenticated:
            if view.action in ('create', 'update'):
                return User.has_profile_program(
                    user=request.user,
                    program_code=request.data.get('code', ''),
                    profile_list=('teacher', 'admin'),
                )
            if view.action in ('destroy',):
                is_admin = User.has_profile_program(
                    user=request.user,
                    program_code=False,
                    profile_list=('admin',),
                )
                if is_admin:
                    return True
                is_teacher = view.queryset.get(
                    pk=view.kwargs['pk'],
                    course__teachers=request.user,
                )
                if is_teacher:
                    return True
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

    permission_classes = (FeedBackCreateUpdateDeleteTeacherAdmin,)


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


class CourseViewSet(viewsets.ModelViewSet):
    """
    ### create `admin|teacher`

    ### destroy `admin|teacher`

    ### update `admin|teacher`

    ### list `admin|teacher|student`
    > Muestra el `Course` de un `Course`

    - ordering
        - `id`
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

    filter_ordering = (
        'id',
        'section',
        'period',
        'campus',
        'subject',
        'survey',
        'period__program',
        'teachers',
        'students',
        # 'active',
        # 'progress_level',
        # 'goal_level',
    )

    queryset = Course.objects.all()
    serializer_class = CourseSerializer
    filter_backends = (DjangoFilterBackend, filters.OrderingFilter,)

    filter_fields = filter_ordering
    ordering_fields = filter_ordering


"""
class MyFilter(django_filters.FilterSet):
    surname = django_filters.CharFilter(name="model_field_name_2")

    order_by_field = 'ordering'
    ordering = OrderingFilter(
        # fields(('model field name', 'parameter name'),)
        fields=(
            ('model_field_name_1', 'name'),
            ('model_field_name_2', 'surname'),
            ('model_field_name_3', 'email'),
        )
    )

    class Meta:
        model = MyList
        fields = ['model_field_name_2',]

class MyListViewSet(viewsets.ModelViewSet):
    serializer_class = MyListSerializer
    filter_backends = (filters.DjangoFilterBackend,)
    filter_class = MyFilter

    def get_queryset(self):
        return MyList.objects.all()
"""