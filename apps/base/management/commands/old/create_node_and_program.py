from django.core.management.base import BaseCommand, CommandError
from django.core.management import call_command
from apps.base.models import User, Profile, UserProfilesProgram
from apps.topology.models import Node, NodeType
from apps.core.models import Program

import json

class Command(BaseCommand):
    help = 'Start [Arquitectura] program'

    def handle(self, *args, **options):

        program_code = '1400S'
        try:
            university_type = NodeType.objects.create(
                name='Universidad',
                code='universidad',
                description='u',
                is_top=True,
                can_have_programs=True,
            )
        except Exception as e:
            print(e)

        try:
            university = Node.objects.create(
                name='Universidad del Desarrollo',
                code='UDD',
                description='udd',
                node_type=university_type,
            )
        except Exception as e:
            print(e)

        try:
            program = Program.objects.create(
                node=university,
                name='Arquitectura',
                code=program_code,
            )
        except Exception as e:
            print(e)

        Profile.objects.create(
            name=Profile.TEACHER,
            code=Profile.TEACHER,
        )

        Profile.objects.create(
            name=Profile.ADMIN,
            code=Profile.ADMIN,
        )

        Profile.objects.create(
            name=Profile.STUDENT,
            code=Profile.STUDENT,
        )
