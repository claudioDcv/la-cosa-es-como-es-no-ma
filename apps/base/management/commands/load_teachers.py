from django.core.management.base import BaseCommand, CommandError
import csv
import json

from apps.base.models import User, Profile, UserProfilesProgram
from apps.core.models import Program


def csv_dict_reader(path, delimiter):
    """Read a CSV file using csv.DictReader.
     > $ ./manage.py load_students location:./_CSV/user_estudiantes.csv
    insert <program_code>:1400S
    insert delimiter:,
    delimiter = delimiter or ';'
    """
    with open(path) as file_obj:
        clean_list = []
        reader = csv.DictReader(file_obj, delimiter=delimiter)
        for line in reader:
            if line.get('email') and line.get('username'):
                line['password'] = line['username'] + line['email']
                line['model'] = 'base.user'
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
        location = options['location']
        program_code = input('insert <program_code>:')
        delimiter = input('insert delimiter:')
        profile_code = Profile.TEACHER

        if location and program_code:
            print(program_code)
            loc = location.split(':')
            if len(loc) == 2:
                path = loc[1]
                reader = csv_dict_reader(path, delimiter)
                for line in reader:
                    try:
                        user = User.objects.create_user(
                            username=line['username'],
                            email=line['email'],
                            first_name=line['first_name'],
                            last_name=line['last_name'],
                            password=line['username'] + line['email'],
                            external_info=line['external_info'],
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
                        us_pr_pr.profiles.add(Profile.objects.get(code=profile_code))

                        self.stdout.write(self.style.SUCCESS(
                            'Teacher:"%s" created' % user.username))