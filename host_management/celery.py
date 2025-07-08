import os

from celery import Celery
from celery.schedules import crontab


# Set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'host_management.settings')

app = Celery('host_management')

# Using a string here means the worker doesn't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#   should have a `CELERY_` prefix.
app.config_from_object('django.conf:settings', namespace='CELERY')

# Load task modules from all registered Django apps.
app.autodiscover_tasks(['hosts.tasks'])


# @app.task(bind=True, ignore_result=True)
# def debug_task(self):
#     print(f'Request: {self.request!r}')


app.conf.beat_schedule = {
    'change-passwords': {
        'task': 'hosts.tasks.change_all_host_passwords',
        'schedule': crontab(hour='*/8'),  # 每8小时执行任务
    },
    'daily-stats': {
        'task': 'hosts.tasks.host_group_stats',
        'schedule': crontab(minute=0, hour=0),  # 每天午夜执行统计任务
    },
    'ping-hosts': {
        'task': 'hosts.tasks.ping_all_hosts',
        'schedule': crontab(minute=0),   # 每小时ping一次
    },
}