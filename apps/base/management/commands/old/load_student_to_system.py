from django.core.management.base import BaseCommand, CommandError
from django.core.management import call_command
from apps.base.models import User, Profile, UserProfilesProgram
from imports_csv.student import csv_dict_reader
from apps.core.models import Program


import json
class Command(BaseCommand):
    help = 'Create users'

    def handle(self, *args, **options):
        student_list = json.loads(csv_dict_reader())
        program_code = '1400S'
        profile_student_code = Profile.STUDENT

        for student in student_list:
            create_us_pr_pr = False
            try:
                external_info = ''
                if student.get('promocion'):
                    external_info = {
                        "promocion": student['promocion'],
                    }
                else:
                    external_info = student['external_info']

                user = User.objects.create_user(
                    username=student['username'],
                    email=student['email'],
                    first_name=student['first_name'],
                    last_name='{0} {1}'.format(
                        student['last_name_1'],
                        student['last_name_2'],
                    ),
                    password=student['username'] + student['email'],
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
                us_pr_pr.profiles.add(Profile.objects.get(code=profile_student_code))

                self.stdout.write(self.style.SUCCESS(
                    'Student:"%s" created' % user.username))
