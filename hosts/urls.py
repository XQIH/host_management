from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()
router.register(r'cities', views.CityViewSet)
router.register(r'computer-rooms', views.ComputerRoomViewSet)
router.register(r'hosts', views.HostViewSet)
router.register(r'host-passwords', views.HostPasswordViewSet)
router.register(r'host-groups', views.HostGroupViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('generate-password/', views.GeneratePasswordView.as_view(), name='generate-password'),
    path('daily-stats/', views.DailyStatsView.as_view(), name='daily-stats'),
]