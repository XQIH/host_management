import secrets
import string

from django.db.models import Count
from django.shortcuts import render
from django.utils import timezone
from rest_framework import viewsets,status
from rest_framework.views import APIView
from .models import City, ComputerRoom, Host, HostPassword, HostGroup
from .serializers import CitySerializer, ComputerRoomSerializer, HostSerializer, HostGroupSerializer, HostPasswordSerializer
from rest_framework.decorators import action
from rest_framework.response import Response
from ping3 import ping
from .tasks import async_ping_host
from datetime import timedelta
import time
from django.utils.deprecation import MiddlewareMixin
from django.dispatch import receiver
from django.db.models.signals import post_save

class CityViewSet(viewsets.ModelViewSet):
    queryset = City.objects.all()
    serializer_class = CitySerializer


class ComputerRoomViewSet(viewsets.ModelViewSet):
    queryset = ComputerRoom.objects.all()
    serializer_class = ComputerRoomSerializer


class HostViewSet(viewsets.ModelViewSet):
    queryset = Host.objects.all()
    serializer_class = HostSerializer

    @action(methods=['get'], detail=False)
    def ping(self, request, pk=None):
        """触发异步ping检测"""
        host = self.get_object()
        task = async_ping_host.delay(host.id)  # 异步调用

        return Response({
            'status': 'pending',
            'task_id': task.id,
            'host_id': host.id,
            'message': 'Ping任务已提交'
        })


class HostPasswordViewSet(viewsets.ModelViewSet):
    queryset = HostPassword.objects.all()
    serializer_class = HostPasswordSerializer

    def perform_create(self, serializer):
        # 创建时自动设置8小时后过期
        serializer.save(
            expiration_time=timezone.now() + timedelta(hours=8)  # 这里是国际时间，控制台输出的也是国际时间
        )

    @receiver(post_save, sender=Host)
    def create_host_password(sender, instance, created, **kwargs):
        """
        当 Host 被创建时，自动生成对应的 HostPassword 记录
        """
        if created:
            HostPassword.objects.create(
                host=instance,
                root_password= secrets.token_urlsafe(16),  # 随机生成
                changed_at=timezone.now(),
                expiration_time=timezone.now() + timedelta(hours=8)
            )


class HostGroupViewSet(viewsets.ModelViewSet):
    queryset = HostGroup.objects.all()
    serializer_class = HostGroupSerializer


class GeneratePasswordView(APIView):
    """
        secrets模块可以生成不可预测的随机数
    """
    def get(self, request):
        length = request.query_params.get('length', 12)  # 默认长度12
        try:
            length = int(length)
            if length < 8 or length > 32:
                raise ValueError
        except ValueError:
            return Response({'error': '密码长度需为8-32的整数'}, status=400)

        # 定义密码包含的字符类型：大小写字母、数字、标点符号
        characters = string.ascii_letters + string.digits + string.punctuation
        # 使用secrets模块生成安全的随机密码
        password = ''.join(secrets.choice(characters) for _ in range(length))

        return Response({
            'password': password,
            'length': length
        })


class DailyStatsView(APIView):
    """每日统计任务"""

    def post(self, request):
        today = timezone.now().date()

        # 按城市统计
        # 查询所有城市，并通过注解方式统计每个城市关联的主机数量（通过机房表进行关联）
        cities = City.objects.annotate(host_count=Count('computerroom__host'))
        for city in cities:
            # 按城市更新或创建主机分组记录，保存当天的主机数量统计
            HostGroup.objects.update_or_create(
                group_type='City',
                city=city,
                date=today,
                defaults={'host_count': city.host_count}
            )

        # 按机房统计
        rooms = ComputerRoom.objects.annotate(host_count=Count('host'))
        for room in rooms:
            HostGroup.objects.update_or_create(
                group_type='ComputerRoom',
                computer_room=room,
                date=today,
                defaults={'host_count': room.host_count}
            )

        return Response({'status': 'success'})


# 创建中间件
class RequestTimeMiddleware(MiddlewareMixin):
    """
    请求耗时中间件
    记录每个请求的处理时间，并将耗时信息添加到响应头中
    """

    def process_request(self, request):
        """
        在请求开始时记录时间戳
        :param request: 请求对象
        """
        request.start_time = time.time()

    def process_response(self, request, response):
        """
        在响应结束时计算请求耗时，并将结果写入响应头
        :param request: 请求对象
        :param response: 响应对象
        :return: 修改后的响应对象
        """
        if hasattr(request, 'start_time'):
            duration = time.time() - request.start_time
            # 添加 X-Request-Duration 响应头，显示请求处理耗时（单位：秒）
            response['X-Request-Duration'] = f"{duration:.3f}s"
        return response


