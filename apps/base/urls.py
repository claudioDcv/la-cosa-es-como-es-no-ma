from django.urls import path
from apps.base.views import IndexView, HomeView, SelfUserDetailView,\
    upload_pic, change_password

urlpatterns = [
    path('', IndexView.as_view(), name='index'),
    path('home', HomeView.as_view(), name='home'),
    path(
        'self-user-detail',
        SelfUserDetailView.as_view(),
        name='self-user-detail'
    ),
    path(
        'self-user-detail-form',
        upload_pic,
        name='self-user-detail-form'
    ),
    path('password', change_password, name='change-password'),
]
