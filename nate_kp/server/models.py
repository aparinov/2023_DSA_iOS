from django.db import models
from django.contrib.auth.models import User

class technical_requirements(models.Model):
    name = models.CharField("name", max_length=255)
    
    class Meta:
        managed = False
        db_table='technical_requirements'
    
class project(models.Model):
    title = models.CharField("title", max_length=255)
    description = models.CharField("description", max_length=5000)
    project_type = models.CharField("project_type", max_length=20)
    supervisor = models.CharField("supervisor", max_length=100, default = "")
    number_of_students = models.IntegerField("number_of_students")
    submission_deadline = models.DateField("submission_deadline")
    application_deadline = models.DateField("application_deadline")
    application_form = models.CharField("application_form", max_length=255)
    status = models.CharField("status", max_length=20)
    
    class Meta:
        managed = False
        db_table='project'

class requirements_stack(models.Model):
    requirement_id = models.IntegerField("requirement_id")
    project_id = models.IntegerField("project_id")
    
    class Meta:
        managed = False
        db_table='requirements_stack'
    
class application(models.Model):
    student_id = models.IntegerField("student_id")
    project_id = models.IntegerField("project_id")
    status = models.CharField("status", max_length=20)
    
    class Meta:
        managed = False
        db_table='application'
    
class student(models.Model):
    email = models.CharField("email", max_length=255)
    
    class Meta:
        managed = False
        db_table='student'


class student_info(models.Model):
    student_id = models.IntegerField("student_id")
    name = models.CharField("name", max_length=255)
    group = models.CharField("group", max_length=10)
    year =models.IntegerField("year")
    faculty = models.CharField("faculty", max_length=255)
    phone_number =  models.CharField("phone_number", max_length=20) 
    
    class Meta:
        managed = False
        db_table='student_info'

class student_interests(models.Model):
    interest_id = models.IntegerField("interest_id")
    student_id = models.IntegerField("student_id")
    
    class Meta:
        managed = False
        db_table='student_interests'

class student_applications(models.Model):
    title   = models.CharField("title", max_length=255)
    description = models.CharField("description", max_length=255)
    project_type = models.CharField("project_type", max_length=20)
    supervisor          = models.CharField("supervisor", max_length=255, default = "")
    number_of_students = models.IntegerField("number_of_students")
    submission_deadline = models.DateField("submission_deadline")
    application_deadline = models.DateField("application_deadline")
    application_form = models.CharField("application_form", max_length=255)
    status = models.CharField("status", max_length=20)
    student_id =  models.IntegerField("student_id", primary_key = True)
    
    class Meta:
        managed = False
        db_table='student_applications'
        
class project_requirements(models.Model):
    project_id   = models.IntegerField("project_id", primary_key = True)
    id = models.IntegerField("requirement_id")
    name = models.CharField("name", max_length=255)
    
    class Meta:
        managed = False
        db_table='project_requirements'

class student_information(models.Model):
    id   = models.IntegerField("student_id", primary_key = True)
    email = models.CharField("email", max_length=255)
    faculty = models.CharField("faculty", max_length=255)
    group          = models.CharField("group", max_length=10)
    name = models.CharField("name", max_length=255)
    phone_number = models.CharField("phone_number", max_length=20)
    year = models.IntegerField("year")
    
    class Meta:
        managed = False
        db_table='student_information'
        
class student_interests_list(models.Model):
    id   = models.IntegerField("student_id", primary_key = True)
    interest_id = models.IntegerField("interest_id")
    name = models.CharField("name", max_length=255)
    
    class Meta:
        managed = False
        db_table='student_interests_list'