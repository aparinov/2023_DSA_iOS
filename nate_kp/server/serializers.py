from rest_framework import serializers
from .models import technical_requirements
from .models import project
from .models import requirements_stack
from .models import application
from .models import student
from .models import student_info
from .models import student_interests
from .models import student_applications
from .models import student_information
from .models import student_interests_list
from .models import project_requirements
from server.models import *
from django.contrib.auth.models import User

class technical_requirementsSerializer(serializers.ModelSerializer):

    class Meta:
        model = technical_requirements
        fields = ['id', 'name']
        
class projectSerializer(serializers.ModelSerializer):

    class Meta:
        model = project
        fields = ['id', 'title', 'description', 'project_type', 'supervisor', 'number_of_students', 'submission_deadline', 'application_deadline', 'application_form', 'status']
        
class requirements_stackSerializer(serializers.ModelSerializer):

    class Meta:
        model = requirements_stack
        fields = ['id', 'project_id', 'requirement_id']
        
class student_interestSerializer(serializers.ModelSerializer):

    class Meta:
        model = student_interests
        fields = ['id', 'student_id', 'interest_id']
        
class applicationSerializer(serializers.ModelSerializer):

    class Meta:
        model = application
        fields = ['id', 'project_id', 'student_id', 'status']
        
class studentSerializer(serializers.ModelSerializer):

    class Meta:
        model = student
        fields = ['id', 'email']
        
class student_infoSerializer(serializers.ModelSerializer):

    class Meta:
        model = student_info
        fields = ['id', 'student_id', 'name', 'group', 'faculty', 'year', 'phone_number']
        
class student_applicationsSerializer(serializers.ModelSerializer):

    class Meta:
        model = student_applications
        fields = ['student_id',  'title', 'description', 'project_type', 'supervisor', 'number_of_students', 'submission_deadline', 'application_deadline', 'application_form', 'status']
        
class student_informationSerializer(serializers.ModelSerializer):

    class Meta:
        model = student_information
        fields = ['id',  'email', 'faculty', 'group', 'name', 'phone_number', 'year']
        
class student_interests_listSerializer(serializers.ModelSerializer):

    class Meta:
        model = student_interests_list
        fields = ['id',  'interest_id', 'name']
        
class project_requirementsSerializer(serializers.ModelSerializer):

    class Meta:
        model = project_requirements
        fields = ['project_id',  'id', 'name']
           

class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(
        write_only=True,
        required=True,
        style={"input_type": "password", "placeholder": "Password"},
    )

    class Meta:
        model = User
        fields = ['id', 'username', 'password']

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
