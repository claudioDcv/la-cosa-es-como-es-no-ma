from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User, Profile, UserProfilesProgram


# admin.site.register(User, UserAdmin)

@admin.register(User)
class UserAdmin(UserAdmin):

    # def get_roles(self, instane):
    #     return [a for a in instane.roles.all()]
    #
    # get_roles.short_description = 'Roles'

    list_display = (
        'username',
        'external_info',
        'email',
        'is_active',
        'is_staff',
        'is_superuser',
    )
    fieldsets = UserAdmin.fieldsets + (
            ('Parametros adicionales', {'fields': ('external_info',)}),
    )



@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ('id',)


@admin.register(UserProfilesProgram)
class UserProfilesProgramAdmin(admin.ModelAdmin):
    list_display = ('id',)
