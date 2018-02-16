from django.db import models
from django.contrib.auth.models import AbstractUser
from django.contrib.postgres.fields import JSONField


class DescriptiveModel(models.Model):
    """
    - implement field: name, code, description and overwrite to string method
    """
    name = models.CharField(max_length=50, verbose_name='nombre')
    code = models.CharField(max_length=100, verbose_name='código', unique=True)
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

    email = models.EmailField(max_length=70, blank=True, null=True, unique=True)
    external_info = JSONField()
    AUTH_USER_EMAIL_UNIQUE = True
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username', 'external_info']


class UserProfilesProgram(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, verbose_name='usuario')
    program = models.ForeignKey('core.Program', on_delete=models.CASCADE, verbose_name='programa')
    profiles = models.ManyToManyField(Profile, 'Perfiles')