from django.core.management.base import BaseCommand, CommandError
import csv
import json

from apps.base.models import User, Profile, UserProfilesProgram
from apps.core.models import Program
from apps.term.models import Course


def csv_dict_reader(path, delimiter):
    """Read a CSV file using csv.DictReader.
     > $ ./manage.py assign_teachers_to_courses location:./_CSV/rel_teacher_course.csv
    insert <program_code>:1400S
    insert delimiter:,
    delimiter = delimiter or ';'
    """
    with open(path) as file_obj:
        clean_list = []
        reader = csv.DictReader(file_obj, delimiter=delimiter)
        for line in reader:
            clean_list.append(line)
    
    return clean_list


class Command(BaseCommand):
    def add_arguments(self, parser):
        # Positional arguments
        # parser.add_argument('poll_id', nargs='+', type=int)

        # Named (optional) arguments
        parser.add_argument(
            'location',
        )

    def handle(self, *args, **options):
        
        # period__code=2018-1
        # period__program__code=1400S
        # code=AAC111
        # section=8
        location = options['location']
        delimiter = input('insert delimiter:')
        program_code = input('insert <program_code>:')
        profile_teacher_code = Profile.TEACHER

        if location and program_code:
            print(program_code)
            loc = location.split(':')
            if len(loc) == 2:
                path = loc[1]
                reader = csv_dict_reader(path, delimiter)

                for el in reader:
                    course = None
                    code = el['code']
                    user = User.objects.get(username=el['username'])

                    us_pr_pr = UserProfilesProgram.objects.get(
                        user=user,
                        program=Program.objects.get(code=program_code),
                    )

                    has_profile = False
                    for prof in us_pr_pr.profiles.all():
                        if prof.code == profile_teacher_code:
                            has_profile = True

                    if has_profile:
                        try:
                            course = Course.objects.get(
                                period__code=el['period'],
                                period__program__code=program_code,
                                code=code,
                                section=el['section'],
                            )
                        except Exception as e:
                            print(e, code)
                            self.stdout.write(
                                self.style.ERROR(
                                    'Error: {0} - {1}'.format(e, code)
                                )
                            )
                        
                        try:
                            course.teachers.add(user)
                        except Exception as e:
                            print(e, user)
                            self.stdout.write(
                                self.style.ERROR(
                                    'Error: {0} - {1}'.format(e, user.username)
                                )
                            )

                # location = options['location']
                # program_code = input('insert <program_code>:')
                # delimiter = input('insert delimiter:')
                # profile_code = Profile.STUDENT

        print(1)