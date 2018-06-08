import csv
import json

from collections import defaultdict

from django.core.management.base import BaseCommand


from apps.base.models import DescriptiveModel
from apps.base.models import Parameter
from apps.base.models import Profile
from apps.base.models import SoftDeleteTSModel
from apps.base.models import User
from apps.base.models import UserProfilesProgram

from apps.business.models import Campus
from apps.business.models import Period
from apps.business.models import Survey

from apps.core.models import Indicator
from apps.core.models import Level
from apps.core.models import Program
from apps.core.models import Skill
from apps.core.models import SkillLevelDescription
from apps.core.models import SkillsGroup
from apps.core.models import Subject
from apps.core.models import SubjectsGroup

from apps.term.models import Course
from apps.term.models import Feedback
from apps.term.models import FinalIndicatorEvaluation
from apps.term.models import FinalScoreEvaluation
from apps.term.models import TempFedbackScore
from apps.term.models import TempFeedbackMessage
from apps.term.models import TempFinalIndicatorEvaluation
from apps.term.models import TempScoreEvaluation

from apps.topology.models import NodeType
from apps.topology.models import NodeTypeParent
from apps.topology.models import Node

from apps.report.constants.managment_commands import EVALUATED
from apps.report.constants.managment_commands import HALF_EVALUATED
from apps.report.constants.managment_commands import NOT_EVALUATED
from apps.report.constants.managment_commands import NUMBER_INDICATORS
from apps.report.constants.managment_commands import NUMBER_STUDENTS

def teacher_1():
    course = Course.objects.get(code='Dario_IntroduccionArte_1')

    json_courses = Course.all_json(
        courses=course,
        show_skills=True,
    )

    result = json_courses[0]['skills']
    for s in result:
        s.pop('group', None)
        s.pop('code', None)
        s.pop('progress_level', None)

    with open('teacher_1.json','w') as f_in:
        f_in.write(str(json.dumps(result)))


def admin_1():
    period = Period.objects.get(code='Dario_2018_1')
    period_2 = Period.objects.get(code='2018-1')

    json_periods = Period.all_json(
        periods=[period, period_2],
        show_skills=True,
    )

    result = []

    for p in json_periods:
        skills = {}
        for s in p['skills']:
            result.append({
                'skill': s['name'],
                'promedio': s['goal_level'],
                'period': p['name'],
            })

    with open('admin_1.json','w') as f_in:
        f_in.write(str(json.dumps(result)))


def admin_2():
    period = Period.objects.get(code='Dario_2018_1')
    period_2 = Period.objects.get(code='2018-1')

    json_periods = Period.all_json(
        periods=[period, period_2],
        show_skills=True,
    )

    groups = defaultdict(list)

    for p in json_periods:
        for s in p['skills']:
            groups[s['group']].append({
                'skill': s['name'],
                'promedio': s['goal_level'],
                'period': p['name'],
            })

    result = dict(groups)

    with open('admin_2.json','w') as f_in:
        f_in.write(str(json.dumps(result)))


def admin_3():
    subject = Subject.objects.get(code='AAC111')
    period = Period.objects.get(code='2018-1')

    json_courses = Course.all_json(
        subjects=subject,
        periods=period,
        show_skills=True,
    )

    result = {}

    for c in json_courses:
        skills = {}
        for s in c['skills']:
            skills[s['name']] = s['goal_level']
        result[c['section']] = skills

    with open('admin_3.json','w') as f_in:
        f_in.write(str(json.dumps(result)))

def course_json():
    course = Course.objects.get(code='Dario_IntroduccionArte_1')
    program = Program.objects.get(code='1400S')
    period = Period.objects.get(code='Dario_2018_1')
    period_2 = Period.objects.get(code='2018-1')
    subject = Subject.objects.get(code='AHA113')
    campus = Campus.objects.get(code='RESB')
    skill = Skill.objects.get(code='CG07')
    skills_group = SkillsGroup.objects.get(code='CG')
    skills_group_2 = SkillsGroup.objects.get(code='CE')
    teacher = User.objects.get(email='dario_profesor_disenoarquitectonico@test.cl')
    teacher_2 = User.objects.get(email='dario_profesor_introduccionarte@test.cl')
    student = User.objects.get(email='dario_alumno_1@test.cl')

    json_courses = Course.all_json(
        # time_status='active',
        # courses=course,
        # program=program,
        periods=period,
        # subjects=subject,
        # campus=campus,
        # skills=skill,
        # skills_groups=skills_group,
        # teachers=[teacher, teacher_2],
        # students=student,
        # progress_level_not_none=None,
        # progress_level_less_than=None,
        # progress_level_greater_than=None,
        # progress_level_less_or_equal_than=None,
        # progress_level_greater_or_equal_than=None,
        # goal_level_not_none=None,
        # goal_level_less_than=None,
        # goal_level_greater_than=None,
        # goal_level_less_or_equal_than=None,
        # goal_level_greater_or_equal_than=None,
        # order_by='progress_level',
        show_skills=True,
        show_skills_groups=True,
        # show_teachers=True,
        # show_students=True,
        as_json=True,
    )

    with open('result_course.json','w') as f_in:
        f_in.write(str(json_courses))

    # courses = json.loads(json_courses)

def period_json():
    program = Program.objects.get(code='1400S')
    period = Period.objects.get(code='Dario_2018_1')
    period_2 = Period.objects.get(code='2018-1')

    json_periods = Period.all_json(
        time_status='all',
        # program=program,
        # periods=[period, period_2],
        # progress_level_not_none=True,
        show_skills=True,
        show_skills_groups=True,
        as_json=True,
    )

    with open('result_period.json','w') as f_in:
        f_in.write(str(json_periods))

    # period = json.loads(json_periods)

class Command(BaseCommand):
    # def add_arguments(self, parser):
    #     parser.add_argument(
    #         '--period', 
    #         dest='period', 
    #         required=True,
    #         help='the period to process',
    #     )

    def handle(self, *args, **options):
        # period_code = options['period']
        # if period_code:
        #     period_qs = Period.objects.filter(code=period_code)
        #     if len(period_qs) == 1:
        #         get_data_from_period(period_qs[0])
        course_json()
        period_json()

        teacher_1()
        admin_1()
        admin_2()
        admin_3()
