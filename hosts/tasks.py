# Create your tasks here
from celery import shared_task
from ping3 import ping
from host_management import settings
from hosts.models import Host, HostPassword
import requests
from django.utils import timezone
from datetime import timedelta


@shared_task(bind=True)
def async_ping_host(self, host_id):
    """
    异步执行ping检测并更新主机状态
    Args:
        host_id: 主机数据库ID
    Returns:
        dict: 包含检测结果和主机信息
    """
    host = Host.objects.get(id=host_id)
    try:
        timeout = 4  # 默认超时4秒
        ping_result = ping(host.ip_address, timeout=timeout)

        # 返回结果（ping3返回延迟秒数或False/None）
        if ping_result is None:
            return {'host': host.name, 'ip_address': host.ip_address, 'reachable': False, 'error': 'Timeout'}
        elif ping_result is False:
            return {'host': host.name, 'ip_address': host.ip_address, 'reachable': False, 'error': 'Network error'}
        else:
            return {
                'host': host.name,
                'ip_address': host.ip_address,
                'reachable': True,
                'latency': round(ping_result * 1000, 2)  # 转为毫秒
            }

    except Exception as e:
        self.retry(exc=e, countdown=60)  # 失败后60秒重试


@shared_task
def ping_all_hosts():
    from hosts.models import Host
    for host in Host.objects.all():
        async_ping_host.delay(host.id)


@shared_task(bind=True)
def change_host_password(self, host_id):
    """
    通过API生成新密码并更新到数据库
    """
    host_pwd = HostPassword.objects.get(host_id=host_id)
    try:
        # 调用内部API生成密码
        resp = requests.get(
            f'http://127.0.0.1:8000/generate-password/',
            params={'length': 16}  # 固定16位长度
        )
        resp.raise_for_status()  # 检查HTTP响应状态码，若非2xx则抛出异常
        new_password = resp.json()['password']

        # 更新数据库
        host_pwd.root_password = new_password
        host_pwd.changed_at = timezone.now()
        host_pwd.expiration_time = timezone.now() + timedelta(hours=8)
        host_pwd.save()
        print('更新数据库成功')
        return {
            'host': host_pwd.host.name,
            'new_password': new_password[:4] + '****',  # 部分隐藏
            'expires_at': host_pwd.expiration_time
        }

    except Exception as e:
        self.retry(exc=e, countdown=60)


@shared_task(bind=True)
def change_all_host_passwords(self):
    try:
        for host in Host.objects.all():
            change_host_password.delay(host.id)
    except Exception as e:
        self.retry(exc=e, countdown=60)


@shared_task
def host_group_stats():
    """
    更新主机分组统计数据
    """
    url = f'http://127.0.0.1:8000/daily-stats/'
    requests.post(url)











