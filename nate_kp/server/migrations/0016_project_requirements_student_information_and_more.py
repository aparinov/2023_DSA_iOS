# Generated by Django 4.1.7 on 2023-03-15 02:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('server', '0015_alter_application_table_alter_project_table'),
    ]

    operations = [
        migrations.CreateModel(
            name='project_requirements',
            fields=[
                ('project_id', models.IntegerField(primary_key=True, serialize=False, verbose_name='project_id')),
                ('id', models.IntegerField(verbose_name='requirement_id')),
                ('name', models.CharField(max_length=255, verbose_name='name')),
            ],
            options={
                'db_table': 'project_requirements',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='student_information',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False, verbose_name='student_id')),
                ('email', models.CharField(max_length=255, verbose_name='email')),
                ('faculty', models.CharField(max_length=255, verbose_name='faculty')),
                ('group', models.CharField(max_length=10, verbose_name='group')),
                ('name', models.CharField(max_length=255, verbose_name='name')),
                ('phone_number', models.CharField(max_length=20, verbose_name='phone_number')),
                ('year', models.IntegerField(verbose_name='year')),
            ],
            options={
                'db_table': 'student_information',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='student_interests_list',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False, verbose_name='student_id')),
                ('interest_id', models.IntegerField(verbose_name='interest_id')),
                ('name', models.CharField(max_length=255, verbose_name='name')),
            ],
            options={
                'db_table': 'project_requirements',
                'managed': False,
            },
        ),
        migrations.AlterModelOptions(
            name='requirements_stack',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='student',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='student_info',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='student_interest',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='technical_requirements',
            options={'managed': False},
        ),
    ]