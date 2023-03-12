from django.db import models
from django.contrib.auth.models import User


# Create your models here.
class Project(models.Model):
    ID = models.IntegerField(primary_key=True)
    title = models.CharField(max_length=200, default='')
    description = models.CharField(max_length=700, default='')
    project_type = models.CharField(max_length=100, default='')
    supervisor = models.CharField(max_length=100, default='')
    number_of_students = models.IntegerField(null=True)
    submission_deadline = models.DateTimeField()
    application_deadline = models.DateTimeField()
    application_form = models.CharField(max_length=500, default='')
    status = models.CharField(max_length=100, default='')


class Applications(models.Model):
    ID = models.IntegerField(primary_key=True)
    student = models.ForeignKey('auth.User', related_name='applications', on_delete=models.CASCADE)
    project = models.ForeignKey('Project', related_name='applications', on_delete=models.CASCADE)


class TechnicalRequirements(models.Model):
    ID = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=100, default='')


class TechStack(models.Model):
    ID = models.IntegerField(primary_key=True)
    project = models.ForeignKey('Project', related_name='stack', on_delete=models.CASCADE)
    tech_requirements = models.ForeignKey('TechnicalRequirements', related_name='stacks', on_delete=models.CASCADE)


class StudentInformation(models.Model):
    ID = models.IntegerField(primary_key=True)
    student = models.ForeignKey('auth.User', related_name='information', on_delete=models.CASCADE)
    name = models.CharField(max_length=200, default='')
    faculty = models.CharField(max_length=200, default='')
    group = models.CharField(max_length=20, default='')
    year = models.IntegerField()
    phone_number = models.CharField(max_length=100, default='')


class StudentsInterests(models.Model):
    ID = models.IntegerField(primary_key=True)
    student = models.ForeignKey('auth.User', related_name='interests', on_delete=models.CASCADE)
    interest = models.ForeignKey('Interest', related_name='students', on_delete=models.CASCADE)


class Interest(models.Model):
    ID = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=200, default='')
