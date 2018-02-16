from django.core.management.base import BaseCommand, CommandError
from django.core.management import call_command
from apps.base.models import User

class Command(BaseCommand):
    help = 'Load Initial Data'

    # def add_arguments(self, parser):
    #     # Positional arguments
    #     parser.add_argument('poll_id', nargs='+', type=int)
    #
    #     # Named (optional) arguments
    #     parser.add_argument(
    #         '--delete',
    #         action='store_true',
    #         dest='delete',
    #         help='Delete poll instead of closing it',
    #     )

    def handle(self, *args, **options):
        users_old = User.objects.count()
        call_command('loaddata', 'base')
        users_new = User.objects.count()

        n = users_new - users_old
        if n > 0:
            self.stdout.write(self.style.SUCCESS('Load user:"%s"' % n))
        else:
            self.stdout.write(self.style.SUCCESS('No user new'))
