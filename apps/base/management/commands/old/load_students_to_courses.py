from django.core.management.base import BaseCommand, CommandError
from django.core.management import call_command
from apps.base.models import User
from apps.term.models import Course
from imports_csv.students_to_courses import csv_dict_reader

import json

class Command(BaseCommand):
    help = 'Create users'

    def handle(self, *args, **options):
        student_list = json.loads(csv_dict_reader())
        asign_users = 0
        create_list_errors = []
        for student in student_list:
            course = Course.objects.get(code=student['course_code'])

            print(student['username'])
            try:
                course.students.add(
                    User.objects.get(username=student['username'])
                )
                asign_users = asign_users + 1
            except Exception as e:
                print(e, student)
                self.stdout.write(
                    self.style.ERROR(
                        'Error: {0} - {1}'.format(e, student['username'])
                    )
                )
                create_list_errors.append({
                    'username': student['username'],
                    'error': e,
                })

        self.stdout.write(
            self.style.SUCCESS(
                'Created: {0}'.format(asign_users)
            )
        )

        self.stdout.write(self.style.SUCCESS('--------------------------'))
        self.stdout.write(self.style.SUCCESS('Not created'))

        for student in create_list_errors:
            self.stdout.write(
                self.style.SUCCESS(student)
            )
