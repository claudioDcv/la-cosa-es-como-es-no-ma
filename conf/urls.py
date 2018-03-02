from django.conf.urls import url
from django.contrib import admin

from django.contrib.auth import views as auth_views
from django.urls import path, include

urlpatterns = [
    path('', include('apps.base.urls')),
    path('', include('apps.core.urls')),
    url(r'^admin/', admin.site.urls),
    path('accounts/', include('django.contrib.auth.urls')),
]
