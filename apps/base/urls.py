from django.urls import path
from apps.base.views import IndexView, HomeView, SelfUserDetailView

urlpatterns = [
    path('', IndexView.as_view(), name='index'),
    path('home', HomeView.as_view(), name='home'),
    path(
        'self-user-detail',
        SelfUserDetailView.as_view(),
        name='self-user-detail'
    ),
]
