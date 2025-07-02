from django.db import models
from django_cryptography.fields import encrypt


# Create your models here.


class City(models.Model):
    name = models.CharField(max_length=30, unique=True, verbose_name="城市名")
    description = models.TextField(blank=True, verbose_name="描述")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="创建时间")  # 自动添加当前时间
    updated_at = models.DateTimeField(auto_now=True, verbose_name="更新时间")  # 自动添加当前时间

    class Meta:
        verbose_name = "城市"
        verbose_name_plural = "城市"

    def __str__(self):
        return self.name


class ComputerRoom(models.Model):
    name = models.CharField(max_length=100, unique=True, verbose_name="机房名称")
    city = models.ForeignKey(City, on_delete=models.PROTECT, verbose_name="所在城市")  # 关联数据阻止删除
    address = models.CharField(max_length=100, verbose_name="机房地址")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="创建时间")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="更新时间")

    class Meta:
        verbose_name = "机房"
        verbose_name_plural = "机房"
        unique_together = ('city', 'name')  # 为城市和机房添加唯一约束，避免重复

    def __str__(self):
        return f"{self.city.name}-{self.name}"  # 返回机房名称和所属城市


class Host(models.Model):
    OS_CHOICES = [
        ('Windows', 'Windows'),
        ('Linux', 'Linux'),
        ('MacOS', 'MacOS'),
        ('Other', 'Other')
    ]

    STATUS_CHOICES = [
        ('Active', '运行中'),
        ('Fault', '故障'),
        ('Maintenance', '维护中'),
        ('Deactivate', '下线'),
        ('Unknown', '未知')
    ]

    name = models.CharField(max_length=100, verbose_name="主机名称", unique=True)
    ip_address = models.GenericIPAddressField(unique=True, verbose_name="IP地址")
    computer_room = models.ForeignKey(ComputerRoom, on_delete=models.PROTECT, verbose_name="所在机房")  # 关联数据阻止删除
    os_type = models.CharField(max_length=20, choices=OS_CHOICES, verbose_name="操作系统")  # 操作系统
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, verbose_name="主机状态")  # 主机状态
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="创建时间")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="更新时间")

    class Meta:
        verbose_name = "主机"
        verbose_name_plural = "主机"

    def __str__(self):
        return f"{self.name} ({self.ip_address})"  # 返回主机名称和IP地址


class HostPassword(models.Model):
    host = models.OneToOneField(Host, on_delete=models.CASCADE, verbose_name="主机")
    root_password = encrypt(models.CharField(max_length=255, verbose_name="root密码"))
    changed_at = models.DateTimeField(auto_now=True, verbose_name="修改时间")
    expiration_time = models.DateTimeField(verbose_name="密码过期时间", null=True)

    class Meta:
        verbose_name = "主机密码"
        verbose_name_plural = "主机密码"

    def __str__(self):
        return f"{self.host.name}的密码 最后修改时间: {self.changed_at}"


class HostGroup(models.Model):
    GROUP_CHOICES = (
        ('City', '城市'),
        ('ComputerRoom', '机房')
    )

    group_type = models.CharField(max_length=20, choices=GROUP_CHOICES, verbose_name="分组类型")
    city = models.ForeignKey(City, on_delete=models.PROTECT, null=True, blank=True, verbose_name="城市")
    computer_room = models.ForeignKey(ComputerRoom, on_delete=models.PROTECT, null=True, blank=True, verbose_name="机房")
    host_count = models.IntegerField(verbose_name="主机数量")
    date = models.DateField(verbose_name="统计日期")

    class Meta:
        verbose_name = "主机统计"
        verbose_name_plural = "主机统计"
        unique_together = [
            ('city', 'group_type', 'date'),
            ('computer_room', 'group_type', 'date')
        ]

    def __str__(self):
        if self.group_type == 'City':
            return f"{self.city.name} {self.date} {self.host_count}台"
        else:
            return f"{self.computer_room.name} {self.date} {self.host_count}台"





