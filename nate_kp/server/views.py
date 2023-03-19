from django.shortcuts import render
from rest_framework import generics, permissions
from .models import technical_requirements
from .models import project
from .models import requirements_stack
from .models import application
from .models import student
from .models import student_info
from .models import student_applications
from .models import student_information
from .models import student_interests_list
from .models import project_requirements
from .models import student_interests
from .serializers import technical_requirementsSerializer
from .serializers import projectSerializer
from .serializers import requirements_stackSerializer
from .serializers import applicationSerializer
from .serializers import studentSerializer
from .serializers import student_infoSerializer
from .serializers import student_applicationsSerializer
from .serializers import student_informationSerializer
from .serializers import student_interests_listSerializer
from .serializers import project_requirementsSerializer
from .serializers import student_interestSerializer
from server.permissions import IsOwner
from rest_framework import serializers


class technical_requirementsCreate(generics.CreateAPIView):
    # API endpoint that allows creation of a new customer
    queryset = technical_requirements.objects.all(),
    serializer_class = technical_requirementsSerializer

class technical_requirementsList(generics.ListAPIView):
    # API endpoint that allows customer to be viewed.
    queryset = technical_requirements.objects.all()
    serializer_class = technical_requirementsSerializer

class technical_requirementsDetail(generics.RetrieveUpdateDestroyAPIView):
    # API endpoint that returns a single customer by pk.
    queryset = technical_requirements.objects.all()
    serializer_class = technical_requirementsSerializer
    
    
    
class projectCreate(generics.CreateAPIView):
    # API endpoint that allows creation of a new customer
    queryset = project.objects.all(),
    serializer_class = projectSerializer

class projectList(generics.ListAPIView):
    # API endpoint that allows customer to be viewed.
    queryset = project.objects.all()
    serializer_class = projectSerializer

class projectDetail(generics.RetrieveUpdateDestroyAPIView):
    # API endpoint that returns a single customer by pk.
    queryset = project.objects.all()
    serializer_class = projectSerializer
    
    
    
class requirements_stackCreate(generics.CreateAPIView):
    # API endpoint that allows creation of a new customer
    queryset = requirements_stack.objects.all(),
    serializer_class = requirements_stackSerializer

class requirements_stackList(generics.ListAPIView):
    # API endpoint that allows customer to be viewed.
    queryset = requirements_stack.objects.all()
    serializer_class = requirements_stackSerializer

class requirements_stackDetail(generics.RetrieveUpdateDestroyAPIView):
    # API endpoint that returns a single customer by pk.
    queryset = requirements_stack.objects.all()
    serializer_class = requirements_stackSerializer
    
    
class student_interestCreate(generics.CreateAPIView):
    # API endpoint that allows creation of a new customer
    queryset = student_interests.objects.all(),
    serializer_class = student_interestSerializer

class student_interestList(generics.ListAPIView):
    # API endpoint that allows customer to be viewed.
    queryset = student_interests.objects.all()
    serializer_class = student_interestSerializer

class student_interestDetail(generics.RetrieveUpdateDestroyAPIView):
    # API endpoint that returns a single customer by pk.
    queryset = student_interests.objects.all()
    serializer_class = student_interestSerializer
    
    
class applicationCreate(generics.CreateAPIView):
    # API endpoint that allows creation of a new customer
    queryset = application.objects.all(),
    serializer_class = applicationSerializer

class applicationList(generics.ListAPIView):
    # API endpoint that allows customer to be viewed.
    queryset = application.objects.all()
    serializer_class = applicationSerializer

class applicationDetail(generics.RetrieveUpdateDestroyAPIView):
    # API endpoint that returns a single customer by pk.
    queryset = application.objects.all()
    serializer_class = applicationSerializer
    
    
class studentCreate(generics.CreateAPIView):
    # API endpoint that allows creation of a new customer
    queryset = student.objects.all(),
    serializer_class = studentSerializer

class studentList(generics.ListAPIView):
    # API endpoint that allows customer to be viewed.
    queryset = student.objects.all()
    serializer_class = studentSerializer

class studentDetail(generics.RetrieveUpdateDestroyAPIView):
    # API endpoint that returns a single customer by pk.
    queryset = student.objects.all()
    serializer_class = studentSerializer
    
    
class student_infoCreate(generics.CreateAPIView):
    # API endpoint that allows creation of a new customer
    queryset = student_info.objects.all(),
    serializer_class = student_infoSerializer

class student_infoList(generics.ListAPIView):
    # API endpoint that allows customer to be viewed.
    queryset = student_info.objects.all()
    serializer_class = student_infoSerializer
    
class student_infoDetail(generics.RetrieveUpdateDestroyAPIView):
    # API endpoint that allows customer to be viewed.
    queryset = student_info.objects.all()
    serializer_class = student_infoSerializer


class student_applicationsDetail(generics.ListAPIView):
    serializer_class = student_applicationsSerializer
    def get_queryset(self):
      studentid = self.kwargs['pk']
      return student_applications.objects.filter(student_id = studentid)
    #queryset = student_applications.objects.all()

class student_informationDetail(generics.ListAPIView):
    #queryset = student_information.objects.all()
    serializer_class = student_informationSerializer
    def get_queryset(self):
      studentid = self.kwargs['pk']
      return student_information.objects.filter(id = studentid)

class student_interests_listDetail(generics.ListAPIView):
    #queryset = student_interests_list.objects.all()
    serializer_class = student_interests_listSerializer
    def get_queryset(self):
      studentid = self.kwargs['pk']
      return student_interests_list.objects.filter(id = studentid)
    
class project_requirementsDetail(generics.ListAPIView):
    #queryset = project_requirements.objects.all()
    serializer_class = project_requirementsSerializer
    def get_queryset(self):
      projectid = self.kwargs['pk']
      return project_requirements.objects.filter(project_id = projectid)