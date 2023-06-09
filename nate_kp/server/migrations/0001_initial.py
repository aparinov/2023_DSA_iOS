# Generated by Django 4.1.7 on 2023-03-13 23:52

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Interest',
            fields=[
                ('ID', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(default='', max_length=200)),
            ],
        ),
        migrations.CreateModel(
            name='Project',
            fields=[
                ('ID', models.IntegerField(primary_key=True, serialize=False)),
                ('title', models.CharField(default='', max_length=200)),
                ('description', models.CharField(default='', max_length=700)),
                ('project_type', models.CharField(default='', max_length=100)),
                ('supervisor', models.CharField(default='', max_length=100)),
                ('number_of_students', models.IntegerField(null=True)),
                ('submission_deadline', models.DateTimeField()),
                ('application_deadline', models.DateTimeField()),
                ('application_form', models.CharField(default='', max_length=500)),
                ('status', models.CharField(default='', max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='TechnicalRequirements',
            fields=[
                ('ID', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(default='', max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='TechStack',
            fields=[
                ('ID', models.IntegerField(primary_key=True, serialize=False)),
                ('project', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='stack', to='server.project')),
                ('tech_requirements', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='stacks', to='server.technicalrequirements')),
            ],
        ),
        migrations.CreateModel(
            name='StudentsInterests',
            fields=[
                ('ID', models.IntegerField(primary_key=True, serialize=False)),
                ('interest', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='students', to='server.interest')),
                ('student', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='interests', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='StudentInformation',
            fields=[
                ('ID', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(default='', max_length=200)),
                ('faculty', models.CharField(default='', max_length=200)),
                ('group', models.CharField(default='', max_length=20)),
                ('year', models.IntegerField()),
                ('phone_number', models.CharField(default='', max_length=100)),
                ('student', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='information', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Applications',
            fields=[
                ('ID', models.IntegerField(primary_key=True, serialize=False)),
                ('project', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='applications', to='server.project')),
                ('student', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='applications', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
