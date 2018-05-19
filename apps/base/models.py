from django.db import models
from django.contrib.auth.models import AbstractUser
from django.contrib.postgres.fields import JSONField
from django.utils import timezone

import PIL
from PIL import Image
from django.core.files.uploadedfile import InMemoryUploadedFile
from django.utils.six import StringIO

#Add to a form containing a FileField and change the field names accordingly.
# from django.template.defaultfilters import filesizeformat
# from django.utils.translation import ugettext_lazy as _
# from django.conf import settings

# # Add to your settings file
# # CONTENT_TYPES = ['image', 'video']
# CONTENT_TYPES = ['image']
# # 2.5MB - 2621440
# # 4MB - 4194304
# # 5MB - 5242880
# # 10MB - 10485760
# # 20MB - 20971520
# # 50MB - 5242880
# # 100MB 104857600
# # 250MB - 214958080
# # 500MB - 429916160
# MAX_UPLOAD_SIZE = "4194304"


# def validate_file_type(upload):
#     import ipdb; ipdb.set_trace()
#     content = self.cleaned_data['content']
#     content_type = content.content_type.split('/')[0]
#     if content_type in settings.CONTENT_TYPES:
#         if content._size > settings.MAX_UPLOAD_SIZE:
#             raise forms.ValidationError(_('Please keep filesize under %s. Current filesize %s') % (filesizeformat(settings.MAX_UPLOAD_SIZE), filesizeformat(content._size)))
#     else:
#         raise forms.ValidationError(_('File type is not supported'))
#     return content
    


class DescriptiveModel(models.Model):
    """
    - implement field: name, code, description and overwrite to string method
    """
    name = models.CharField(max_length=250, verbose_name='nombre')
    code = models.CharField(max_length=100, verbose_name='código', unique=True, blank=False, null=False,)
    description = models.TextField(blank=True, verbose_name='descripción')

    class Meta:
        abstract = True

    def __str__(self):
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
    STUDENT = 'student'
    TEACHER = 'teacher'
    SECRETARY = 'secretary'
    SUPERVISOR = 'supervisor'
    ADMIN = 'admin'
    ROLE_CHOICES = (
      (STUDENT, 'student'),
      (TEACHER, 'teacher'),
      (SECRETARY, 'secretary'),
      (SUPERVISOR, 'supervisor'),
      (ADMIN, 'admin'),
    )

    code = models.CharField(
        max_length=10,
        choices=ROLE_CHOICES,
        default='student',
        primary_key=True,
    )


    def __str__(self):
        return '{0} {1}'.format(self.name, self.code)


def user_directory_path(instance, filename):
    # file will be uploaded to MEDIA_ROOT/user_<id>/<filename>
    return 'user_{0}/{1}'.format(instance.id, filename)


class User(AbstractUser):

    image_profile = models.ImageField(upload_to=user_directory_path, blank=True, null=True)
    email = models.EmailField(max_length=70, blank=False, null=False, unique=True)
    code = models.CharField(max_length=100, blank=True, null=True, unique=True)
    external_info = JSONField()
    AUTH_USER_EMAIL_UNIQUE = True
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username', 'external_info']

    def save(self, *args, **kwargs):

        if self.image_profile:

            try:
                if self.image_profile.file.content_type in ['image/jpg', 'image/png', 'image/jpeg']:
                    if self.image_profile.size <= 4194304:

                        super().save(*args, **kwargs)

                        # READ IMAGE AND RESIZE
                        size = 120, 120
                        im = Image.open(self.image_profile)
                        im.thumbnail(size, Image.ANTIALIAS)
                        im.save(self.image_profile.path, "JPEG")

                        '''
                        image = Image.open(self.image_profile)
                        # cropped_image = image.crop((x, y, w+x, h+y))
                        resized_image = image.thumbnail((150, 150), Image.ANTIALIAS)
                        resized_image.save(self.image_profile.path)
                        '''

                        return

            except Exception as _:
                pass
            
        super().save(*args, **kwargs)

        # if getattr(self, '_image_changed', True):
        #     small=rescale_image(self.image,width=100,height=100)
        #     self.image_small=SimpleUploadedFile(name,small_pic)
    
    def link(self):
        # Return some calculated value based on the entry
        return self.id
        

    @staticmethod
    def has_profile_program(user, program_code, profile_list):
        """
        - profile_list <tuple/list>: contains <str>
        - ej: ('teacher', 'admin')
        """
        if type(profile_list) != tuple:
            profile_list = (profile_list,)

        profiles = Profile.objects.filter(code__in=profile_list).all()
        if program_code:
            profile = UserProfilesProgram.objects.filter(
                user=user,
                program__code=program_code,
                profiles__in=profiles,
            ).all()
        else:
            profile = UserProfilesProgram.objects.filter(
                user=user,
                profiles__in=profiles,
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

    def __str__(self):
        return '{0} {1}'.format(self.name, self.code)

    class Meta:
        unique_together = (('code', 'program'),)
