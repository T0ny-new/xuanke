# Generated by Django 4.2.4 on 2024-01-17 14:31

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Colleges',
            fields=[
                ('id', models.CharField(max_length=13, primary_key=True, serialize=False, verbose_name='学院编号')),
                ('name', models.CharField(max_length=20, verbose_name='学院名称')),
                ('createTime', models.CharField(db_column='create_time', max_length=19, verbose_name='记录时间')),
            ],
            options={
                'db_table': 'colleges',
            },
        ),
        migrations.CreateModel(
            name='Grades',
            fields=[
                ('id', models.CharField(max_length=13, primary_key=True, serialize=False, verbose_name='年级编号')),
                ('name', models.CharField(max_length=20, verbose_name='年级名称')),
                ('createTime', models.CharField(db_column='create_time', max_length=19, verbose_name='记录时间')),
            ],
            options={
                'db_table': 'grades',
            },
        ),
        migrations.CreateModel(
            name='Majors',
            fields=[
                ('id', models.CharField(max_length=13, primary_key=True, serialize=False, verbose_name='专业编号')),
                ('name', models.CharField(max_length=20, verbose_name='专业名称')),
                ('createTime', models.CharField(db_column='create_time', max_length=19, verbose_name='记录时间')),
            ],
            options={
                'db_table': 'majors',
            },
        ),
        migrations.CreateModel(
            name='Projects',
            fields=[
                ('id', models.CharField(max_length=13, primary_key=True, serialize=False, verbose_name='课程编号')),
                ('name', models.CharField(max_length=20, verbose_name='课程名称')),
                ('createTime', models.CharField(db_column='create_time', max_length=19, verbose_name='记录时间')),
            ],
            options={
                'db_table': 'projects',
            },
        ),
        migrations.CreateModel(
            name='Users',
            fields=[
                ('id', models.CharField(max_length=13, primary_key=True, serialize=False, verbose_name='用户编号')),
                ('userName', models.CharField(db_column='user_name', max_length=32, verbose_name='用户账号')),
                ('passWord', models.CharField(db_column='pass_word', max_length=32, verbose_name='用户密码')),
                ('name', models.CharField(max_length=20, verbose_name='用户姓名')),
                ('age', models.IntegerField(verbose_name='用户年龄')),
                ('gender', models.CharField(max_length=4, verbose_name='用户性别')),
                ('type', models.IntegerField(verbose_name='用户身份')),
            ],
            options={
                'db_table': 'users',
            },
        ),
        migrations.CreateModel(
            name='Teachers',
            fields=[
                ('user', models.OneToOneField(db_column='id', max_length=13, on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to='app.users')),
                ('record', models.CharField(max_length=8, verbose_name='教师学历')),
                ('phone', models.CharField(max_length=11, verbose_name='联系电话')),
                ('address', models.CharField(max_length=32, verbose_name='联系地址')),
            ],
            options={
                'db_table': 'teachers',
            },
        ),
        migrations.CreateModel(
            name='WorkPalns',
            fields=[
                ('id', models.CharField(max_length=13, primary_key=True, serialize=False, verbose_name='记录编号')),
                ('grade', models.ForeignKey(db_column='grade_id', max_length=13, on_delete=django.db.models.deletion.CASCADE, to='app.grades')),
                ('project', models.ForeignKey(db_column='project_id', max_length=13, on_delete=django.db.models.deletion.CASCADE, to='app.projects')),
                ('teacher', models.ForeignKey(db_column='teacher_id', max_length=13, on_delete=django.db.models.deletion.CASCADE, to='app.teachers')),
            ],
            options={
                'db_table': 'work_palns',
            },
        ),
        migrations.CreateModel(
            name='Students',
            fields=[
                ('user', models.OneToOneField(db_column='id', max_length=13, on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to='app.users')),
                ('college', models.ForeignKey(db_column='college_id', max_length=13, on_delete=django.db.models.deletion.CASCADE, to='app.colleges')),
                ('grade', models.ForeignKey(db_column='grade_id', max_length=13, on_delete=django.db.models.deletion.CASCADE, to='app.grades')),
                ('major', models.ForeignKey(db_column='major_id', max_length=13, on_delete=django.db.models.deletion.CASCADE, to='app.majors')),
            ],
            options={
                'db_table': 'students',
            },
        ),
        migrations.CreateModel(
            name='SelectLogs',
            fields=[
                ('id', models.CharField(max_length=13, primary_key=True, serialize=False, verbose_name='记录编号')),
                ('workPaln', models.ForeignKey(db_column='plan_id', max_length=13, on_delete=django.db.models.deletion.CASCADE, to='app.workpalns')),
                ('student', models.ForeignKey(db_column='student_id', max_length=13, null=True, on_delete=django.db.models.deletion.CASCADE, to='app.students')),
            ],
            options={
                'db_table': 'select_logs',
            },
        ),
    ]
