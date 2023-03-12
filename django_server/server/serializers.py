from rest_framework import serializers
from server.models import *
from django.contrib.auth.models import User


class ProjectSerializer(serializers.ModelSerializer):
    applications = serializers.PrimaryKeyRelatedField(many=True, queryset=Applications.objects.all())
    stack = serializers.PrimaryKeyRelatedField(many=True, queryset=TechnicalRequirements.objects.all())

    class Meta:
        model = Project
        fields = '__all__'


class ApplicationsSerializer(serializers.ModelSerializer):
    student = serializers.ReadOnlyField(source='student.username')

    class Meta:
        model = Applications
        fields = '__all__'


class TechnicalRequirementsSerializer(serializers.ModelSerializer):
    stacks = serializers.PrimaryKeyRelatedField(many=True, queryset=TechStack.objects.all())

    class Meta:
        model = TechnicalRequirements
        fields = '__all__'


class TechStackSerializer(serializers.ModelSerializer):

    class Meta:
        model = TechStack
        fields = '__all__'


class StudentInformationSerializer(serializers.ModelSerializer):
    student = serializers.ReadOnlyField(source='student.username')

    class Meta:
        model = StudentInformation
        fields = '__all__'


class StudentsInterestsSerializer(serializers.ModelSerializer):
    student = serializers.ReadOnlyField(source='student.username')

    class Meta:
        model = StudentsInterests
        fields = '__all__'


class InterestSerializer(serializers.ModelSerializer):
    students = serializers.PrimaryKeyRelatedField(many=True, queryset=StudentsInterests.objects.all())

    class Meta:
        model = Interest
        fields = '__all__'


class UserSerializer(serializers.ModelSerializer):
    applications = serializers.PrimaryKeyRelatedField(many=True, queryset=Applications.objects.all())
    information = serializers.PrimaryKeyRelatedField(many=False, queryset=StudentInformation.objects.all())
    interests = serializers.PrimaryKeyRelatedField(many=True, queryset=StudentsInterests.objects.all())

    password = serializers.CharField(
        write_only=True,
        required=True,
        style={"input_type": "password", "placeholder": "Password"},
    )

    class Meta:
        model = User
        fields = ['id', 'username', 'password', 'applications', 'information', 'interests']

    def create(self, validated_data, **kwargs):
        """
        Overriding the default create method of the Model serializer.
        """
        print(validated_data)
        user = User(
            username=validated_data["username"]
        )
        password = validated_data["password"]
        user.set_password(password)
        user.save()
        return user
