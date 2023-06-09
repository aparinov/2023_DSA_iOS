# Generated by Django 4.1.7 on 2023-03-14 10:54

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('server', '0007_requirements_stack'),
    ]

    operations = [
        migrations.CreateModel(
            name='student',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('email', models.CharField(max_length=255, verbose_name='email')),
            ],
        ),
        migrations.CreateModel(
            name='application',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('status', models.CharField(max_length=20, verbose_name='status')),
                ('project_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='%(class)s_id', to='server.project')),
                ('student_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='%(class)s_id', to='server.student')),
            ],
        ),
    ]
