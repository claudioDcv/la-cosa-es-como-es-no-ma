from django.core.management.base import BaseCommand, CommandError
import csv
import json

from apps.base.models import User, Profile, UserProfilesProgram
from apps.core.models import Program
from apps.term.models import Course


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

        if location and program_code:
            print(program_code)
            loc = location.split(':')
            if len(loc) == 2:
                path = loc[1]
                reader = csv_dict_reader(path, delimiter)

                for el in reader:
                    period__program__code = el['period']
                    code = el['code']
                    import ipdb; ipdb.set_trace()
                    user = User.objects.get(username=el['username'])
                    
                    profiles = user.user_profiles_program.all()
                    
                    import ipdb; ipdb.set_trace()

                program_code = input('insert <program_code>:')
                program_code = input('insert <program_code>:')
                program_code = input('insert <program_code>:')


                location = options['location']
                program_code = input('insert <program_code>:')
                delimiter = input('insert delimiter:')
                profile_code = Profile.STUDENT

        print(1)