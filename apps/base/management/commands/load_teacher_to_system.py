from django.core.management.base import BaseCommand, CommandError
from django.core.management import call_command
from apps.base.models import User, Profile, UserProfilesProgram
from apps.core.models import Program
from imports_csv.teacher import csv_dict_reader

import json
class Command(BaseCommand):
    help = 'Create users'

    def handle(self, *args, **options):
        teacher_list = json.loads(csv_dict_reader())
        program_code = '1400S'
        profile_teacher_code = Profile.TEACHER

        for teacher in teacher_list:
            create_us_pr_pr = False
            try:
                external_info = ''
                if teacher.get('promocion'):
                    external_info = {
                        "promocion": teacher['promocion'],
                    }
                else:
                    external_info = teacher['external_info']

                if teacher.get('last_name_1'):
                    last_name = '{0} {1}'.format(
                        teacher['last_name_1'],
                        teacher['last_name_2'],
                    )
                else:
                    last_name = teacher['last_name']

                user = User.objects.create_user(
                    username=teacher['username'],
                    email=teacher['email'],
                    first_name=teacher['first_name'],
                    last_name=last_name,
                    password=teacher['username'] + teacher['email'],
                    external_info=external_info,
                )
                create_us_pr_pr = True
            except Exception as e:
                print(e)
                create_us_pr_pr = False

            if create_us_pr_pr:
                us_pr_pr = UserProfilesProgram.objects.create(
                    user=user,
                    program=Program.objects.get(code=program_code),
                )
                us_pr_pr.profiles.add(Profile.objects.get(code=profile_teacher_code))

                self.stdout.write(self.style.SUCCESS(
                    'teacher:"%s" created' % user.username))
