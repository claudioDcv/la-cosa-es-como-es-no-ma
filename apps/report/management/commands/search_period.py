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

## HARDCODED
MIN_INDICATOR_VALUE = 0
MAX_INDICATOR_VALUE = 3

def get_data_from_period(period):
    # TODO: Program, Subject, Skill
    total_values_all = defaultdict(lambda : defaultdict(lambda : defaultdict(lambda : defaultdict(float))))

    total_values_course_student = defaultdict(lambda : defaultdict(list))
    total_values_course_teacher = defaultdict(lambda : defaultdict(list))
    total_values_course_skill = defaultdict(lambda : defaultdict(list))
    total_values_student_teacher = defaultdict(lambda : defaultdict(list))
    total_values_student_skill = defaultdict(lambda : defaultdict(list))
    total_values_teacher_skill = defaultdict(lambda : defaultdict(list))

    total_values_course = defaultdict(list)
    total_values_student = defaultdict(list)
    total_values_teacher = defaultdict(list)
    total_values_skill = defaultdict(list)

    courses = Course.objects.filter(
        period=period,
    )

    for course in courses:
        students = course.students.all()
        indicators = course.survey.indicator.all()
        teachers = course.teachers.all()

        for student in students:
            for teacher in teachers:
                for indicator in indicators:
                    skill = indicator.skill

                    final_value_list = FinalIndicatorEvaluation.objects.filter(
                        course=course,
                        evaluated=student,
                        evaluator=teacher,
                        indicator=indicator,
                    ).values_list('value', flat=True)

                    value = final_value_list[0] if len(final_value_list) > 0 else None

                    total_values_all[course][student][teacher][skill] = value

                    total_values_course_student[course][student].append(value)
                    total_values_course_teacher[course][teacher].append(value)
                    total_values_course_skill[course][skill].append(value)
                    total_values_student_teacher[student][teacher].append(value)
                    total_values_student_skill[student][skill].append(value)
                    total_values_teacher_skill[teacher][skill].append(value)

                    total_values_course[course].append(value)
                    total_values_student[student].append(value)
                    total_values_teacher[teacher].append(value)
                    total_values_skill[skill].append(value)

    # Courses
    print("Courses")
    for course, total_values in total_values_course.items():
        total_evaluated_values = [v for v in total_values if v is not None]

        len_total_evaluated_values = len(total_evaluated_values)
        len_total_values = len(total_values)
        sum_total_evaluated_values = sum(total_evaluated_values)
        max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

        total_progress_level_percentage = round(float((len_total_evaluated_values) * 100)/len_total_values,0) if len_total_values > 0 else None
        total_goal_level_percentage = round(float((sum_total_evaluated_values) * 100)/max_total_evaluated_values,0) if max_total_evaluated_values > 0 else None

        print("""
            course : {course}
            total_progress_level_percentage : {total_progress_level_percentage}
            total_goal_level_percentage : {total_goal_level_percentage}
        """.format(
            course=course.name,
            total_progress_level_percentage='{v:.0f}%'.format(v=total_progress_level_percentage) if total_progress_level_percentage is not None else None,
            total_goal_level_percentage='{v:.0f}%'.format(v=total_goal_level_percentage) if total_goal_level_percentage is not None else None,
        ))

    # Students
    print("Students")
    for student, total_values in total_values_student.items():
        total_evaluated_values = [v for v in total_values if v is not None]

        len_total_evaluated_values = len(total_evaluated_values)
        len_total_values = len(total_values)
        sum_total_evaluated_values = sum(total_evaluated_values)
        max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

        total_progress_level_percentage = round(float((len_total_evaluated_values) * 100)/len_total_values,0) if len_total_values > 0 else None
        total_goal_level_percentage = round(float((sum_total_evaluated_values) * 100)/max_total_evaluated_values,0) if max_total_evaluated_values > 0 else None

        print("""
            student : {student}
            total_progress_level_percentage : {total_progress_level_percentage}
            total_goal_level_percentage : {total_goal_level_percentage}
        """.format(
            student=student.email,
            total_progress_level_percentage='{v:.0f}%'.format(v=total_progress_level_percentage) if total_progress_level_percentage is not None else None,
            total_goal_level_percentage='{v:.0f}%'.format(v=total_goal_level_percentage) if total_goal_level_percentage is not None else None,
        ))

    # Teachers
    print("Teachers")
    for teacher, total_values in total_values_teacher.items():
        total_evaluated_values = [v for v in total_values if v is not None]

        len_total_evaluated_values = len(total_evaluated_values)
        len_total_values = len(total_values)
        sum_total_evaluated_values = sum(total_evaluated_values)
        max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

        total_progress_level_percentage = round(float((len_total_evaluated_values) * 100)/len_total_values,0) if len_total_values > 0 else None
        total_goal_level_percentage = round(float((sum_total_evaluated_values) * 100)/max_total_evaluated_values,0) if max_total_evaluated_values > 0 else None

        print("""
            teacher : {teacher}
            total_progress_level_percentage : {total_progress_level_percentage}
            total_goal_level_percentage : {total_goal_level_percentage}
        """.format(
            teacher=teacher.email,
            total_progress_level_percentage='{v:.0f}%'.format(v=total_progress_level_percentage) if total_progress_level_percentage is not None else None,
            total_goal_level_percentage='{v:.0f}%'.format(v=total_goal_level_percentage) if total_goal_level_percentage is not None else None,
        ))

    # Skills
    print("Skills")
    for skill, total_values in total_values_skill.items():
        total_evaluated_values = [v for v in total_values if v is not None]

        len_total_evaluated_values = len(total_evaluated_values)
        len_total_values = len(total_values)
        sum_total_evaluated_values = sum(total_evaluated_values)
        max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

        total_progress_level_percentage = round(float((len_total_evaluated_values) * 100)/len_total_values,0) if len_total_values > 0 else None
        total_goal_level_percentage = round(float((sum_total_evaluated_values) * 100)/max_total_evaluated_values,0) if max_total_evaluated_values > 0 else None

        print("""
            skill : {skill}
            total_progress_level_percentage : {total_progress_level_percentage}
            total_goal_level_percentage : {total_goal_level_percentage}
        """.format(
            skill=skill.name,
            total_progress_level_percentage='{v:.0f}%'.format(v=total_progress_level_percentage) if total_progress_level_percentage is not None else None,
            total_goal_level_percentage='{v:.0f}%'.format(v=total_goal_level_percentage) if total_goal_level_percentage is not None else None,
        ))


    # Courses - Students
    print("Courses - Students")
    for course, students in total_values_course_student.items():
        for student, total_values in students.items():
            total_evaluated_values = [v for v in total_values if v is not None]

            len_total_evaluated_values = len(total_evaluated_values)
            len_total_values = len(total_values)
            sum_total_evaluated_values = sum(total_evaluated_values)
            max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

            total_progress_level_percentage = round(float((len_total_evaluated_values) * 100)/len_total_values,0) if len_total_values > 0 else None
            total_goal_level_percentage = round(float((sum_total_evaluated_values) * 100)/max_total_evaluated_values,0) if max_total_evaluated_values > 0 else None

            print("""
                course : {course}
                student : {student}
                total_progress_level_percentage : {total_progress_level_percentage}
                total_goal_level_percentage : {total_goal_level_percentage}
            """.format(
                course=course.name,
                student=student.email,
                total_progress_level_percentage='{v:.0f}%'.format(v=total_progress_level_percentage) if total_progress_level_percentage is not None else None,
                total_goal_level_percentage='{v:.0f}%'.format(v=total_goal_level_percentage) if total_goal_level_percentage is not None else None,
            ))


    # Courses - Teachers
    print("Courses - Teachers")
    for course, teachers in total_values_course_teacher.items():
        for teacher, total_values in teachers.items():
            total_evaluated_values = [v for v in total_values if v is not None]

            len_total_evaluated_values = len(total_evaluated_values)
            len_total_values = len(total_values)
            sum_total_evaluated_values = sum(total_evaluated_values)
            max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

            total_progress_level_percentage = round(float((len_total_evaluated_values) * 100)/len_total_values,0) if len_total_values > 0 else None
            total_goal_level_percentage = round(float((sum_total_evaluated_values) * 100)/max_total_evaluated_values,0) if max_total_evaluated_values > 0 else None

            print("""
                course : {course}
                teacher : {teacher}
                total_progress_level_percentage : {total_progress_level_percentage}
                total_goal_level_percentage : {total_goal_level_percentage}
            """.format(
                course=course.name,
                teacher=teacher.email,
                total_progress_level_percentage='{v:.0f}%'.format(v=total_progress_level_percentage) if total_progress_level_percentage is not None else None,
                total_goal_level_percentage='{v:.0f}%'.format(v=total_goal_level_percentage) if total_goal_level_percentage is not None else None,
            ))


    # Courses - Skills
    print("Courses - Skills")
    for course, skills in total_values_course_skill.items():
        for skill, total_values in skills.items():
            total_evaluated_values = [v for v in total_values if v is not None]

            len_total_evaluated_values = len(total_evaluated_values)
            len_total_values = len(total_values)
            sum_total_evaluated_values = sum(total_evaluated_values)
            max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

            total_progress_level_percentage = round(float((len_total_evaluated_values) * 100)/len_total_values,0) if len_total_values > 0 else None
            total_goal_level_percentage = round(float((sum_total_evaluated_values) * 100)/max_total_evaluated_values,0) if max_total_evaluated_values > 0 else None

            print("""
                course : {course}
                skill : {skill}
                total_progress_level_percentage : {total_progress_level_percentage}
                total_goal_level_percentage : {total_goal_level_percentage}
            """.format(
                course=course.name,
                skill=skill.name,
                total_progress_level_percentage='{v:.0f}%'.format(v=total_progress_level_percentage) if total_progress_level_percentage is not None else None,
                total_goal_level_percentage='{v:.0f}%'.format(v=total_goal_level_percentage) if total_goal_level_percentage is not None else None,
            ))


    # Students - Teachers
    print("Students - Teachers")
    for student, teachers in total_values_student_teacher.items():
        for teacher, total_values in teachers.items():
            total_evaluated_values = [v for v in total_values if v is not None]

            len_total_evaluated_values = len(total_evaluated_values)
            len_total_values = len(total_values)
            sum_total_evaluated_values = sum(total_evaluated_values)
            max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

            total_progress_level_percentage = round(float((len_total_evaluated_values) * 100)/len_total_values,0) if len_total_values > 0 else None
            total_goal_level_percentage = round(float((sum_total_evaluated_values) * 100)/max_total_evaluated_values,0) if max_total_evaluated_values > 0 else None

            print("""
                student : {student}
                teacher : {teacher}
                total_progress_level_percentage : {total_progress_level_percentage}
                total_goal_level_percentage : {total_goal_level_percentage}
            """.format(
                student=student.email,
                teacher=teacher.email,
                total_progress_level_percentage='{v:.0f}%'.format(v=total_progress_level_percentage) if total_progress_level_percentage is not None else None,
                total_goal_level_percentage='{v:.0f}%'.format(v=total_goal_level_percentage) if total_goal_level_percentage is not None else None,
            ))


    # Student - Skills
    print("Student - Skills")
    for student, skills in total_values_student_skill.items():
        for skill, total_values in skills.items():
            total_evaluated_values = [v for v in total_values if v is not None]

            len_total_evaluated_values = len(total_evaluated_values)
            len_total_values = len(total_values)
            sum_total_evaluated_values = sum(total_evaluated_values)
            max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

            total_progress_level_percentage = round(float((len_total_evaluated_values) * 100)/len_total_values,0) if len_total_values > 0 else None
            total_goal_level_percentage = round(float((sum_total_evaluated_values) * 100)/max_total_evaluated_values,0) if max_total_evaluated_values > 0 else None

            print("""
                student : {student}
                skill : {skill}
                total_progress_level_percentage : {total_progress_level_percentage}
                total_goal_level_percentage : {total_goal_level_percentage}
            """.format(
                student=student.email,
                skill=skill.name,
                total_progress_level_percentage='{v:.0f}%'.format(v=total_progress_level_percentage) if total_progress_level_percentage is not None else None,
                total_goal_level_percentage='{v:.0f}%'.format(v=total_goal_level_percentage) if total_goal_level_percentage is not None else None,
            ))


    # Teachers - Skills
    print("Teachers - Skills")
    for teacher, skills in total_values_teacher_skill.items():
        for skill, total_values in skills.items():
            total_evaluated_values = [v for v in total_values if v is not None]

            len_total_evaluated_values = len(total_evaluated_values)
            len_total_values = len(total_values)
            sum_total_evaluated_values = sum(total_evaluated_values)
            max_total_evaluated_values = len_total_evaluated_values * (MAX_INDICATOR_VALUE - MIN_INDICATOR_VALUE)

            total_progress_level_percentage = round(float((len_total_evaluated_values) * 100)/len_total_values,0) if len_total_values > 0 else None
            total_goal_level_percentage = round(float((sum_total_evaluated_values) * 100)/max_total_evaluated_values,0) if max_total_evaluated_values > 0 else None

            print("""
                teacher : {teacher}
                skill : {skill}
                total_progress_level_percentage : {total_progress_level_percentage}
                total_goal_level_percentage : {total_goal_level_percentage}
            """.format(
                teacher=teacher.email,
                skill=skill.name,
                total_progress_level_percentage='{v:.0f}%'.format(v=total_progress_level_percentage) if total_progress_level_percentage is not None else None,
                total_goal_level_percentage='{v:.0f}%'.format(v=total_goal_level_percentage) if total_goal_level_percentage is not None else None,
            ))




class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            '--period', 
            dest='period', 
            required=True,
            help='the period to process',
        )

    def handle(self, *args, **options):
        period_code = options['period']
        if period_code:
            period_qs = Period.objects.filter(code=period_code)
            if len(period_qs) == 1:
                get_data_from_period(period_qs[0])

