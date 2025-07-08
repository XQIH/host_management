from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views


router = DefaultRouter()  # 初始化路由
router.register(r'cities', views.CityViewSet)  # 城市视图
router.register(r'computer-rooms', views.ComputerRoomViewSet)  # 机房视图
router.register(r'hosts', views.HostViewSet)  # 主机视图
router.register(r'host-passwords', views.HostPasswordViewSet)  # 主机密码视图
router.register(r'host-groups', views.HostGroupViewSet)  # 主机统计视图

urlpatterns = [
    path('', include(router.urls)),
    path('generate-password/', views.GeneratePasswordView.as_view(), name='generate-password'),
    path('daily-stats/', views.DailyStatsView.as_view(), name='daily-stats'),
]