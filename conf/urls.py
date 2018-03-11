from django.conf.urls import url
from django.contrib import admin

from django.contrib.auth import views as auth_views
from django.urls import path, include

from django.conf import settings

urlpatterns = [
    path('', include('apps.base.urls')),
    path('', include('apps.core.urls')),
    path('api/v1/', include('apps.term.api.urls')),
    url(r'^admin/', admin.site.urls),
    path('accounts/', include('django.contrib.auth.urls')),
]

if settings.DEBUG:
    import debug_toolbar
    urlpatterns = [
        url(r'^__debug__/', include(debug_toolbar.urls)),
    ] + urlpatterns
