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

def course_json():
    print(Course.json())

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
