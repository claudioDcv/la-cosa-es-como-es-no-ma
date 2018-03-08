from django.db import models
from django.contrib.auth.models import AbstractUser
from django.contrib.postgres.fields import JSONField


class DescriptiveModel(models.Model):
    """
    - implement field: name, code, description and overwrite to string method
    """
    name = models.CharField(max_length=50, verbose_name='nombre')
    code = models.CharField(max_length=100, verbose_name='código', unique=True, blank=False, null=False,)
    description = models.TextField(blank=True, verbose_name='descripción')

    class Meta:
        abstract = True

    def __str__ (self):
        return '{0} {1}'.format(self.name, self.code)


class SoftDeleteTSModel(models.Model):
    """
    - Soft Delete & Time Stamp Abstrac Model
    """
    is_deleted = models.BooleanField(default=False)
    created_ts = models.DateTimeField(auto_now_add=True)
    updated_ts = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True

    def soft_delete(self):
        self.is_deleted = True
        self.deleted_at = timezone.now()
        self.save()


class Profile(SoftDeleteTSModel, DescriptiveModel):
  """
  The Role entries are managed by the system,
  automatically created via a Django data migration.
  """
  STUDENT = 1
  TEACHER = 2
  SECRETARY = 3
  SUPERVISOR = 4
  ADMIN = 5
  ROLE_CHOICES = (
      (STUDENT, 'student'),
      (TEACHER, 'teacher'),
      (SECRETARY, 'secretary'),
      (SUPERVISOR, 'supervisor'),
      (ADMIN, 'admin'),
  )

  id = models.PositiveSmallIntegerField(choices=ROLE_CHOICES, primary_key=True)

  def __str__(self):
      return self.get_id_display()


class User(AbstractUser):

    email = models.EmailField(max_length=70, blank=False, null=False, unique=True)
    external_info = JSONField()
    AUTH_USER_EMAIL_UNIQUE = True
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username', 'external_info']

    @staticmethod
    def has_profile_program(user, program_code, profile_list):
        """
        - profile_list <tuple/list>: contains <str>
        - ej: ('teacher', 'admin')
        """
        profile_id = 0
        if type(profile_list) == int:
            profile_id = profile_list
        else:
            for profile in Profile.ROLE_CHOICES:
                if profile[1] in profile_list:
                    profile_id = profile[0]

        profile = UserProfilesProgram.objects.filter(
            user=user,
            program__code=program_code,
            profiles=profile_id,
        ).all()
        return len(profile) > 0


class UserProfilesProgram(models.Model):
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        verbose_name='usuario',
        related_name='user_profiles_program'
    )
    program = models.ForeignKey('core.Program', on_delete=models.CASCADE, verbose_name='programa')
    profiles = models.ManyToManyField(Profile, 'Perfiles')

    class Meta:
        unique_together = ("user", "program")


class Parameter(SoftDeleteTSModel, models.Model):
    name = models.CharField(max_length=50, verbose_name='nombre')
    code = models.CharField(max_length=100, verbose_name='código', blank=False, null=False,)
    value = models.TextField(blank=True, verbose_name='valor')
    program = models.ForeignKey(
        'core.Program',
        on_delete=models.CASCADE,
        verbose_name='programa',
        blank=True,
        null=True,
    )

    class Meta:
        abstract = True

    def __str__ (self):
        return '{0} {1}'.format(self.name, self.code)

    class Meta:
        unique_together = (('code', 'program'),)
