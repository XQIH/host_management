from django.contrib import admin

# Register your models here.

# hosts/admin.py
from django.contrib import admin
from .models import City, ComputerRoom, Host, HostPassword, HostGroup
from hosts.tasks import async_ping_host

admin.site.register(City)
admin.site.register(ComputerRoom)
# admin.site.register(Host)
admin.site.register(HostPassword)
admin.site.register(HostGroup)


@admin.register(Host)
class HostAdmin(admin.ModelAdmin):
    list_display = ('name', 'ip_address', 'status', 'updated_at')
    actions = ['ping_selected_hosts']

    def ping_selected_hosts(self, request, queryset):
        for host in queryset:
            # 调用 Celery 异步任务
            async_ping_host.delay(host.id)

        self.message_user(request, f"已发起 {queryset.count()} 个主机的 Ping 检测")
    ping_selected_hosts.short_description = "Ping 所选主机"

