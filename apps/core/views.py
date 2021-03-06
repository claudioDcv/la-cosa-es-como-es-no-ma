import json
import functools

from django.views.generic import TemplateView
from django.views.generic.detail import DetailView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import get_object_or_404
from apps.base.views import get_context_current_profile
from django.http import Http404
from django.core.paginator import Paginator, EmptyPage, InvalidPage


from django.db.models import Q

from apps.core.models import Program
from apps.term.models import Course, Feedback, FinalIndicatorEvaluation
from apps.base.models import Profile, User, UserProfilesProgram
from apps.base.helpers import get_score, student_list_with_indicator,\
    evaluated_with_indicator, get_periods, pagineitor


from apps.core.models import Skill, Indicator

from apps.business.models import Survey

from apps.base.models import Parameter


def paginateitor(queryset, page_out):
    per_page = 5
    paginator = Paginator(queryset, per_page)
    
    try:
        page = page_out
    except:
        page = 1

    try:
        blogs = paginator.page(page)
    except(EmptyPage, InvalidPage):
        blogs = paginator.page(1)

    # Get the index of the current page
    index = blogs.number - 1  # edited to something easier without index
    # This value is maximum index of your pages, so the last page - 1
    max_index = len(paginator.page_range)
    # You want a range of 7, so lets calculate where to slice the list
    start_index = index - 3 if index >= 3 else 0
    end_index = index + 3 if index <= max_index - 3 else max_index
    # Get our new page range. In the latest versions of Django page_range returns 
    # an iterator. Thus pass it to list, to make our slice possible again.
    page_range = list(paginator.page_range)[start_index:end_index]

    return {
        'objects': blogs,
        'page_range': page_range,
    }


def calc_percentage(x, total):
    return (x * 100) / total


class SkillGroupIndexView(LoginRequiredMixin, DetailView):

    template_name = 'core/skill_group_index.html'

    def get_object(self):
        """Get obj."""
        return Course.objects.filter(
            subject__subjects_group__program__code=self.kwargs['code']
            ).only('survey_id', 'teachers', 'students')

    def get_context_data(self, **kwargs):
        """Get ctx."""
        context = super().get_context_data(**kwargs)
        context['score_description'] = json.loads(Parameter.objects.get(code='score_description').value)

        context['code'] = self.kwargs['code']
        context['period'] = get_periods(context['code']).get('now').first().id

        context['profile'] = self.kwargs['profile']
        score = get_score()
        context['score'] = score

        context['program'] = Program.objects.get(code=self.kwargs['code'])
        user = self.request.user

        context = get_context_current_profile(context, self)

        if context['current_profile']:

            if context['current_profile'].code == 'teacher':
                obj = self.get_object()
                context['courses'] = obj.filter(teachers=user)

            elif context['current_profile'].code == 'student':

                obj = self.get_object()
                #  traer todos los cursos donde participa el estudiante
                context['courses'] = obj.filter(students=user)

                #  listado de ids de las encuestas de los cursos
                survey_ids = [x.survey_id for x in context['courses']]

                # lista de encuestas
                survey_list = Survey.objects.filter(id__in=survey_ids)

                skill_ids = []
                for survey in survey_list:
                    for indicator in survey.indicator.all():
                        skill_ids.append(indicator.skill_id)

                #  ademas esta lista es unica
                # listado de indicadores y skill que pertenecen a los ramos que
                # tiene el estudiante
                skill_ids = list(set(skill_ids))

                skill_list = Skill.objects.filter(id__in=skill_ids)

                #  procedimiento para armar listado de indicadores evaluados
                # construccion de objeto de competencias con estudiante evaluado
                final_skill_list = []
                for skill in skill_list:

                    # traer todos los indicadores de la competencia
                    indicator_list = skill.indicator_set.values(
                        'name', 'id', 'description'
                    ).all()
                    final_indicator_list = []
                    skill_value = 0
                    evaluated_at_least_once = False
                    len_final_ind_eval_list = 0
                    ind_percent_sum = 0
                    indicator_evaluated = 0

                    for indicator in indicator_list:

                        final_ind_eval_list = FinalIndicatorEvaluation.\
                            objects.filter(
                                evaluated=user,
                                indicator_id=indicator.get('id'),
                            ).only('value').all()

                        ind_value = 0
                        is_evaluated = False
                        len_final_ind_eval_list = len(final_ind_eval_list)
                        if len_final_ind_eval_list > 0:
                            is_evaluated = True
                            indicator_evaluated = indicator_evaluated + 1
                            evaluated_at_least_once = True
                            for final_ind_eval in final_ind_eval_list:
                                ind_value = ind_value + final_ind_eval.value
                                skill_value = skill_value + final_ind_eval.value

                        #  creando dicionario para luego serializar como json
                        
                        try:
                            ind_percent = calc_percentage(
                                ind_value,
                                len_final_ind_eval_list,
                            ) / score['max']  #noqa
                        except ZeroDivisionError:
                            ind_percent = 0

                        ind_percent_sum = ind_percent_sum + ind_percent
                        str_percent = str(
                            ind_percent
                            )[:4] if len(str(
                                ind_percent
                                )) > 4 else str(ind_percent)


                        final_indicator_list.append({
                            'object': {
                                'name': indicator.get('name'),
                                'description': indicator.get('description'),
                            },
                            'value': ind_value,
                            'str_percent': str_percent,
                            'percent': ind_percent,
                            'is_evaluated': is_evaluated,
                        })

                    # Creando dicionario para luego serializar como json.
                    try:
                        str_percent = (str(
                            ind_percent_sum / indicator_evaluated)[:4]) if len(str(ind_percent_sum / indicator_evaluated)) > 4 else str(ind_percent_sum / indicator_evaluated)  #noqa
                        percent = ind_percent_sum / indicator_evaluated
                    except ZeroDivisionError:
                        str_percent = 0
                        percent = 0

                    final_skill_list.append({
                        'object': {
                            'id': skill.id,
                            'name': skill.name,
                            'description': skill.description,
                        },
                        'str_percent': str_percent,
                        'percent': percent,
                        'value': skill_value,
                        'indicator_list': final_indicator_list,
                        'evaluated_at_least_once': evaluated_at_least_once,
                    })

                context['skill_list'] = final_skill_list
                context['json_skill_list'] = json.dumps(final_skill_list)

            if context['current_profile'].code == 'admin':
                context['courses'] = obj
        return context


class ProgramIndexView(LoginRequiredMixin, DetailView):
    """Program Index."""
    model = Program
    slug_field = 'code'
    template_name = 'core/program_index.html'

    def get_object(self):
        """Get obj."""
        program = get_object_or_404(Program, code=self.kwargs['code'])
        return program

    def get_context_data(self, **kwargs):
        user = self.request.user
        score = get_score()
        """Get ctx."""
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['period'] = self.kwargs['period']
        context['profile'] = self.kwargs['profile']

        context['courses'] = None

        context['periods'] = get_periods(context['code'], context['period'])

        context = get_context_current_profile(context, self)

        if context['current_profile']:
            has_admin = UserProfilesProgram.objects.filter(
                user=user,
                profiles__code=Profile.ADMIN,
                program=context['program'],
            ).count() > 0

            queryset = None

            if context['current_profile'].code == 'admin' and has_admin:
                queryset = Course.objects.filter(
                    subject__subjects_group__program=self.get_object(),
                    period=context['period'],
                )
            
            if context['current_profile'].code == 'teacher':
                queryset = Course.objects.filter(
                    teachers=user,
                    subject__subjects_group__program=self.get_object(),
                    period=context['period'],
                )
            
            if context['current_profile'].code == 'student':
                
                queryset = Course.objects.filter(
                    students=user,
                    subject__subjects_group__program=self.get_object(),
                    period=context['period'],
                )

            # Pagination and order sort
            try:
                page = int(self.request.GET.get('page', '1'))
            except:
                page = 1
          
            try:
                order_by = self.request.GET.get('order_by', 'id')
            except:
                order_by = 'id'
            
            try:
                q = self.request.GET.get('q', '')
            except:
                q = ''
            
            if order_by:
                queryset = queryset.order_by(*order_by.split(','))
            
            if order_by:
                queryset = queryset.filter(
                    Q(name__icontains=q) |
                    Q(code__icontains=q)
                )

            paginator = pagineitor(queryset, page)


            context['courses'] = paginator['objects'].object_list
            context['paginator'] = paginator['objects']
            context['page_range'] = paginator['page_range']

            context['order_by'] = order_by
            context['q'] = q

            context['querystring'] = '?q={2}&page={0}&order_by={1}'.format(
                context['paginator'].number,
                order_by,
                q
            )
            context['querystring_order_by'] = '?q={1}&page={0}&order_by'.format(
                context['paginator'].number,
                q
            )
            context['querystring_page'] = '?q={1}&order_by={0}&page'.format(
                order_by,
                q
            )
            # End Pagination
            
            final_indicator_evaluation = FinalIndicatorEvaluation.objects.filter(
                        course__in=context['courses'],
                    ).values('id', 'course_id', 'indicator__name', 'value').all()
            
            course_return = []
            for course in context['courses']:
                tot_student = course.students.count()
                tot_ind_in_courses = course.survey.indicator.count()
                tot_stud_ind_in_course = tot_student * tot_ind_in_courses

                total_final_indicator_evaluation = list(filter(lambda x, course=course: x['course_id'] == course.id, final_indicator_evaluation))

                progress = int((len(total_final_indicator_evaluation) * 100) / (1 if tot_stud_ind_in_course == 0 else tot_stud_ind_in_course))
                
                teachers = course.teachers.values('id', 'last_name', 'first_name').all()

                values = [x['value'] for x in total_final_indicator_evaluation]
                
                # 26 26=100 16=x
                achievement_sum = functools.reduce((lambda x, y: x + y), values, 0.0)

                # 16 = score['max']
                achievement_total = len(total_final_indicator_evaluation)

                achievement = (achievement_sum * 100) / ((1 if achievement_total == 0 else achievement_total) * score['max'])
                # achievement =  (len(total_final_indicator_evaluation) * 100) / ((1 if len(values) == 0 else len(values)) * score['max'])

                course_return.append({
                    'course': course,
                    'progress': progress,
                    'teachers': teachers,
                    'achievement': achievement,
                })

            context['courses'] = course_return

        return context


class CourseView(LoginRequiredMixin, DetailView):
    model = Course
    template_name = 'core/course.html'

    def get_context_data(self, **kwargs):
        """Get ctx."""

        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']
        context['period'] = self.kwargs['period']

        context = get_context_current_profile(context, self)

        context['score'] = get_score()
        context['program'] = Program.objects.get(code=self.kwargs['code'])

        internal_id_name = Parameter.objects.get(code='internal_id').value
        
        students = student_list_with_indicator(self.kwargs['pk'], None, internal_id_name)

        context['str_total_half_percent'] = students['str_total_half_percent']
        context['total_half_percent'] = students['total_half_percent']
        context['total_indicators'] = students['total_indicators']
        context['students_with_indicator'] = students[
            'students_with_indicator']
        context['course_evaluation_progress'] = students[
            'course_evaluation_progress']
        context['course_evaluation_include_indicator_progress'] = students[
            'course_evaluation_include_indicator_progress']

        return context


class EvaluatedIndexEvaluatorView(LoginRequiredMixin, DetailView):
    model = User
    template_name = 'core/evaluated_evaluator_index.html'

    def get_context_data(self, **kwargs):
        """Get ctx."""
        context = super().get_context_data(**kwargs)
        context['period'] = self.kwargs['period']

        context['score_description'] = json.loads(Parameter.objects.get(code='score_description').value)

        has_admin = UserProfilesProgram.objects.filter(
            user=self.request.user,
            profiles__code=Profile.ADMIN,
            program__code=self.kwargs['code'],
        ).count() > 0

        has_teacher = UserProfilesProgram.objects.filter(
            user=self.request.user,
            profiles__code=Profile.TEACHER,
            program__code=self.kwargs['code'],
        ).count() > 0

        if has_teacher:
            context['code'] = self.kwargs['code']
            context['profile'] = self.kwargs['profile']
            context['program'] = Program.objects.get(code=self.kwargs['code'])
            context['course'] = Course.objects.filter(pk=self.kwargs['course_id']).first()

            context['score'] = get_score()
            context['evaluated'] = evaluated_with_indicator(
                self.kwargs['course_id'], self.get_object())
            context['feedback_list'] = Feedback.objects.filter(
                course=context['course'],
                evaluated=self.get_object().pk,
            ).all()
            context = get_context_current_profile(context, self)
            return context
        elif has_admin:
            context['code'] = self.kwargs['code']
            context['profile'] = self.kwargs['profile']
            context['program'] = Program.objects.get(code=self.kwargs['code'])
            context['course'] = Course.objects.filter(pk=self.kwargs['course_id']).first()
            context['score'] = get_score()
            context['evaluated'] = evaluated_with_indicator(
                self.kwargs['course_id'], self.get_object())
            context['feedback_list'] = Feedback.objects.filter(
                course=context['course'],
            ).all()

            context = get_context_current_profile(context, self)
            return context
        else:
            raise Http404("Does not exist")

        context = get_context_current_profile(context, self)

        return context


class EvaluatedIndexView(LoginRequiredMixin, TemplateView):
    template_name = 'core/evaluated_index.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['code'] = self.kwargs['code']
        context['profile'] = self.kwargs['profile']
        context['period'] = self.kwargs['period']
        context['program'] = Program.objects.get(code=self.kwargs['code'])
        
        context['course'] = Course.objects.filter(
            pk=self.kwargs['course_id'],
            students=self.request.user,
        ).first()

        if context['course'] == None:
            raise Http404("Does not exist")

        context['score'] = get_score()
        context['evaluated'] = evaluated_with_indicator(
            self.kwargs['course_id'], self.request.user)


        context['total_indicators'] = len(context['evaluated'].get('indicator_list')) + len(context['evaluated'].get('indicator_whitout_evaluated')) 
        context['feedback_list'] = Feedback.objects.filter(
            course=context['course'],
            evaluated=self.request.user.id,
        ).all()

        context = get_context_current_profile(context, self)

        return context
