import re
from django import template
from django.utils.safestring import mark_safe

from apps.base.models import Profile

register = template.Library()


@register.filter(name='is_profile')
def is_profile(value, arg):
    profile = arg
    current_profile = value
    current_profile_name = ''
    for prof in current_profile.ROLE_CHOICES:
        if prof[0] == current_profile.id:
            current_profile_name = prof[1]
    return current_profile_name == profile

# {% has_profile curr=current_profile eval='admin' %}
@register.simple_tag
def has_profile(*args, **kwargs):
    profile = kwargs['eval']
    current_profile = kwargs['curr']
    current_profile_name = ''
    for prof in current_profile.ROLE_CHOICES:
        if prof[0] == current_profile.id:
            current_profile_name = prof[1]
    return current_profile_name == profile

@register.simple_tag
def form_as_bootstrap4(*args, **kwargs):
    form = kwargs['form']
    ctx = form.as_p()
    out = re.sub(r'(\<input)|(\<textarea)|(\<select)', r'\1\2\3 class="form-control"', ctx)

    names = re.findall(r'name="([a-zA-Z0-9\-\_]+)"', ctx)

    for v in names:
        if v in form.errors:
            out = re.sub(r'name="{0}"'.format(v), r'name="{0}" data-error'.format(v), out)

    out = re.sub(r'(\<p)', r'<div class="form-group"', out)
    out = re.sub(r'(\</p>)', r'</div>', out)
    return mark_safe(out)


# @register.simple_tag(takes_context=True)
# def current_time(context, *args, **kwargs):
#     request = context['request']
#     import ipdb; ipdb.set_trace()
#     user_profiles_program = request.user.user_profiles_program.get(
#         profiles=kwargs['profile'],
#         program__code=kwargs['code'],
#     )
#     import ipdb; ipdb.set_trace()
#     return 'hola'
