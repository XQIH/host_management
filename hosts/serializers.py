from rest_framework import serializers
from .models import City, ComputerRoom, Host, HostPassword, HostGroup


class CitySerializer(serializers.ModelSerializer):
    """
    城市信息序列化类
    提供城市模型的序列化支持，包含所有字段
    """
    class Meta:
        model = City
        fields = '__all__'


class ComputerRoomSerializer(serializers.ModelSerializer):
    """
    机房信息序列化类
    包含基础字段及关联城市的名称
    city_name: 只读字段，表示所属城市的名称
    """
    city_name = serializers.CharField(source='city.name', read_only=True)

    class Meta:
        model = ComputerRoom
        fields = '__all__'


class HostSerializer(serializers.ModelSerializer):
    """
    主机信息序列化类
    包含主机及其关联机房和城市的信息
    computer_room_name: 只读字段，表示所属机房的名称
    city_name: 只读字段，表示所属机房所在城市的名称
    """
    computer_room_name = serializers.CharField(source='computer_room.name', read_only=True)
    city_name = serializers.CharField(source='computer_room.city.name', read_only=True)


    class Meta:
        model = Host
        fields = '__all__'


class HostPasswordSerializer(serializers.ModelSerializer):
    """
    主机密码序列化类
    管理主机的root密码
    root_password: 写入时加密处理，读取时不返回原始值
    """
    class Meta:
        model = HostPassword
        fields = '__all__'
        extra_kwargs = {
            'root_password': {'write_only': True}
        }


class HostGroupSerializer(serializers.ModelSerializer):
    """
    主机组管理序列化类
    支持主机组的基本信息展示，包括动态计算的组名
    group_name: 动态属性，根据组类型返回对应的城市或机房名称
    """
    group_name = serializers.SerializerMethodField()

    class Meta:
        model = HostGroup
        fields = '__all__'

    def get_group_name(self, obj):
        """
        根据组类型获取对应的名称
        :param obj: HostGroup实例
        :return: str - 城市名称或机房名称
        """
        return obj.city.name if obj.group_type == 'City' else obj.computer_room.name