import json
import time
from django.core import serializers
from django.core.paginator import Paginator
from django.db.models import Q
from django.http import HttpResponse, JsonResponse, HttpResponseRedirect
from django.shortcuts import render
from app import models

'''
检查指定的参数是否存在
存在返回 True
不存在返回 False
'''
def isExit(param):

    if (param == None) or (param == ''):
        return False
    else:
        return True

'''
转换分页查询信息
'''
def parasePage(pageIndex, pageSize, pageTotal, count, data):

    return {'pageIndex': pageIndex, 'pageSize': pageSize, 'pageTotal': pageTotal, 'count': count, 'data': data}

'''
成功响应信息
'''
def success(msg = '处理成功'):
    resl = {'code': 0, 'msg': msg}
    return HttpResponse(json.dumps(resl), content_type='application/json; charset=utf-8')

'''
成功响应信息, 携带数据
'''
def successData(data, msg = '处理成功'):
    resl = {'code': 0, 'msg': msg, 'data': data}
    return HttpResponse(json.dumps(resl), content_type='application/json; charset=utf-8')

'''
系统警告信息
'''
def warn(msg = '操作异常，请重试'):
    resl = {'code': 1, 'msg': msg}
    return HttpResponse(json.dumps(resl), content_type='application/json; charset=utf-8')

'''
系统异常信息
'''
def error(msg = '系统异常'):

    resl = {'code': 2, 'msg': '系统异常'}
    return HttpResponse(json.loads(resl), content_type='application/json; charset=utf-8')



def sys_index_view(request):

    return render(request, "Index.html")

def sys_login_view(request):

    return render(request, "login.html")

def sys_login_data(request):
    userName = request.POST.get('userName')
    passWord = request.POST.get('passWord')

    user = models.Users.objects.filter(userName=userName)

    if(user.exists()):

        user = user.first()
        if user.passWord == passWord:
            login_user = {
                'id': user.id,
                'userName': user.userName,
                'passWord': user.passWord,
                'name': user.name,
                'age': user.age,
                'gender': user.gender,
                'type': user.type,
            }
            request.session["user"] = login_user

            return success()
        else:
            return warn('用户密码输入错误')
    else:
        return warn('用户名输入错误')

def sys_logout_view(request):

    del request.session["user"]
    return HttpResponseRedirect('/projects/login')

def sys_info_data(request):

    user = request.session.get('user')

    data = models.Users.objects.filter(id=user['id'])

    resl = {}
    for item in data:
        resl = {
            'id': item.id,
            'userName': item.userName,
            'passWord': item.passWord,
            'name': item.name,
            'age': item.age,
            'gender': item.gender,
            'type': item.type,
        }

    return successData(resl)

def sys_info_form_data(request):

    user = request.session.get('user')

    models.Users.objects.filter(id = user['id']).update(
                                       userName=request.POST.get('userName'),
                                       name=request.POST.get('name'),
                                        age=request.POST.get('age'),
                                       gender=request.POST.get('gender'),
                                       )

    data = models.Users.objects.filter(id=user['id'])

    resl = {}
    for item in data:
        resl = {
            'id': item.id,
            'userName': item.userName,
            'passWord': item.passWord,
            'name': item.name,
            'age': item.age,
            'gender': item.gender,
            'type': item.type,
        }

    del request.session["user"]
    request.session["user"] = resl

    return successData(user)


def sys_pwd_form_data(request):
    user = request.session.get('user')

    models.Users.objects.filter(id=user['id']).update(
                                    passWord=request.POST.get('password'),
                                    )

    data = models.Users.objects.filter(id=user['id'])

    resl = {}
    for item in data:
        resl = {
            'id': item.id,
            'userName': item.userName,
            'passWord': item.passWord,
            'name': item.name,
            'age': item.age,
            'gender': item.gender,
            'type': item.type,
        }

    del request.session["user"]
    request.session["user"] = resl

    return successData(user)

def college_view(request):

    return render(request, "Colleges.html")

def college_data_page(request):
    pageIndex = request.GET.get('pageIndex', 1)
    pageSize = request.GET.get('pageSize', 10)
    name = request.GET.get('name')

    if isExit(name):
        data = models.Colleges.objects.all().filter(name__contains=name).order_by("-createTime")
    else:
        data = models.Colleges.objects.all().order_by("-createTime")

    paginator = Paginator(data, pageSize)

    resl = []
    for item in list(paginator.page(pageIndex)):
        temp = {
            'id': item.id,
            'name': item.name,
            'createTime': item.createTime
        }
        resl.append(temp)

    temp = parasePage(pageIndex, pageSize,
                      paginator.page(pageIndex).paginator.num_pages, paginator.count, resl)

    return successData(temp)

def college_data_info(request):

    id = request.GET.get('id')

    data = models.Colleges.objects.filter(id=id)

    resl = {}
    for item in data:
        resl = {
            'id': item.id,
            'name': item.name,
            'createTime': item.createTime
        }

    return successData(resl)

def college_data_add(request):

    models.Colleges.objects.create(id = int(time.time()),
                                   name = request.POST.get('name'),
                                   createTime = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
                                  )
    return success()

def college_data_upd(request):

    models.Colleges.objects.filter(id = request.POST.get('id')).update(name=request.POST.get('name'))
    return success()

def college_data_del(request):

    if models.Students.objects.filter(college__id=request.POST.get('id')).exists():

        return warn('学院学生未结业，无法删除')
    else:

        models.Colleges.objects.filter(id=request.POST.get('id')).delete()
        return success()


def major_view(request):

    return render(request, "Majors.html")

def major_data_page(request):
    pageIndex = request.GET.get('pageIndex', 1)
    pageSize = request.GET.get('pageSize', 10)
    name = request.GET.get('name')

    if isExit(name):
        data = models.Majors.objects.all().filter(name__contains=name).order_by("-createTime")
    else:
        data = models.Majors.objects.all().order_by("-createTime")

    paginator = Paginator(data, pageSize)

    resl = []
    for item in list(paginator.page(pageIndex)):
        temp = {
            'id': item.id,
            'name': item.name,
            'createTime': item.createTime
        }
        resl.append(temp)

    temp = parasePage(pageIndex, pageSize,
                      paginator.page(pageIndex).paginator.num_pages, paginator.count, resl)

    return successData(temp)

def major_data_info(request):

    id = request.GET.get('id')

    data = models.Majors.objects.filter(id=id)

    resl = {}
    for item in data:
        resl = {
            'id': item.id,
            'name': item.name,
            'createTime': item.createTime
        }

    return successData(resl)

def major_data_add(request):

    models.Majors.objects.create(id = int(time.time()),
                                   name = request.POST.get('name'),
                                   createTime = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
                                  )
    return success()

def major_data_upd(request):

    models.Majors.objects.filter(id = request.POST.get('id')).update(name=request.POST.get('name'))
    return success()

def major_data_del(request):

    if models.Students.objects.filter(major__id=request.POST.get('id')).exists():

        return warn('学生未结业，无法删除')
    else:

        models.Majors.objects.filter(id=request.POST.get('id')).delete()
        return success()


def project_view(request):

    return render(request, "Projects.html")

def project_data_page(request):
    pageIndex = request.GET.get('pageIndex', 1)
    pageSize = request.GET.get('pageSize', 10)
    name = request.GET.get('name')

    if isExit(name):
        data = models.Projects.objects.all().filter(name__contains=name).order_by("-createTime")
    else:
        data = models.Projects.objects.all().order_by("-createTime")

    paginator = Paginator(data, pageSize)

    resl = []
    for item in list(paginator.page(pageIndex)):
        temp = {
            'id': item.id,
            'name': item.name,
            'createTime': item.createTime
        }
        resl.append(temp)

    temp = parasePage(pageIndex, pageSize,
                      paginator.page(pageIndex).paginator.num_pages, paginator.count, resl)

    return successData(temp)

def project_data_info(request):

    id = request.GET.get('id')

    data = models.Projects.objects.filter(id=id)

    resl = {}
    for item in data:
        resl = {
            'id': item.id,
            'name': item.name,
            'createTime': item.createTime
        }

    return successData(resl)

def project_data_grade(request):

    select_projects = []

    select_project_data = models.WorkPalns.objects.filter(grade__id = request.POST.get('id')).values_list('project_id')
    for item in select_project_data:
        select_projects.append(item)

    projects = models.Projects.objects.exclude(id__in = select_projects)

    resl = []
    for item in projects:


        temp = {
            'id': item.id,
            'name': item.name
        }
        resl.append(temp)

    return successData(resl)

def project_data_add(request):

    models.Projects.objects.create(id = int(time.time()),
                                   name = request.POST.get('name'),
                                   createTime = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
                                  )
    return success()

def project_data_upd(request):

    models.Projects.objects.filter(id = request.POST.get('id')).update(name=request.POST.get('name'))
    return success()

def project_data_del(request):
    models.Projects.objects.filter(id=request.POST.get('id')).delete()
    return success()



def grade_view(request):

    return render(request, "Grades.html")

def grade_data_page(request):
    pageIndex = request.GET.get('pageIndex', 1)
    pageSize = request.GET.get('pageSize', 10)
    name = request.GET.get('name')

    if isExit(name):
        data = models.Grades.objects.all().filter(name__contains=name).order_by("-createTime")
    else:
        data = models.Grades.objects.all().order_by("-createTime")

    paginator = Paginator(data, pageSize)

    resl = []
    for item in list(paginator.page(pageIndex)):
        temp = {
            'id': item.id,
            'name': item.name,
            'createTime': item.createTime
        }
        resl.append(temp)

    temp = parasePage(pageIndex, pageSize,
                      paginator.page(pageIndex).paginator.num_pages, paginator.count, resl)

    return successData(temp)

def grade_data_info(request):

    id = request.GET.get('id')

    data = models.Grades.objects.filter(id=id)

    resl = {}
    for item in data:
        resl = {
            'id': item.id,
            'name': item.name,
            'createTime': item.createTime
        }

    return successData(resl)

def grade_data_add(request):

    models.Grades.objects.create(id = int(time.time()),
                                   name = request.POST.get('name'),
                                   createTime = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
                                  )
    return success()

def grade_data_upd(request):

    models.Grades.objects.filter(id = request.POST.get('id')).update(name=request.POST.get('name'))
    return success()

def grade_data_del(request):

    if models.Students.objects.filter(grade__id=request.POST.get('id')).exists():

        return warn('学生未结业，无法删除')
    else:

        models.Grades.objects.filter(id=request.POST.get('id')).delete()
        return success()



def students_view(request):

    colleges = models.Colleges.objects.all().values()
    majors = models.Majors.objects.all().values()
    grades = models.Grades.objects.all().values()

    return render(request, "Students.html", {'colleges': list(colleges), 'majors': list(majors), 'grades': list(grades)})

def students_data_page(request):
    pageIndex = request.GET.get('pageIndex', 1)
    pageSize = request.GET.get('pageSize', 10)
    studentName = request.GET.get('studentName')
    majorId = request.GET.get('majorId')
    collegeId = request.GET.get('collegeId')
    gradeId = request.GET.get('gradeId')

    qruery = Q();

    if isExit(studentName):
        qruery = qruery & Q(user__name__contains = studentName)

    if isExit(collegeId):
        qruery = qruery & Q(college__id = collegeId)

    if isExit(majorId):
        qruery = qruery & Q(major__id = majorId)

    if isExit(gradeId):
        qruery = qruery & Q(grade__id = gradeId)

    data = models.Students.objects.filter(qruery)

    paginator = Paginator(data, pageSize)

    resl = []
    for item in list(paginator.page(pageIndex)):
        temp = {
            'id': item.user.id,
            'name': item.user.name,
            'age': item.user.age,
            'gender': item.user.gender,
            'majorId': item.major.id,
            'majorName': item.major.name,
            'collegeId': item.college.id,
            'collegeName': item.college.name,
            'gradeId': item.grade.id,
            'gradeName': item.grade.name,
        }
        resl.append(temp)

    temp = parasePage(pageIndex, pageSize,
                      paginator.page(pageIndex).paginator.num_pages, paginator.count, resl)

    return successData(temp)

def students_data_info(request):

    id = request.GET.get('id')

    data = models.Students.objects.filter(user__id=id)

    resl = {}
    for item in data:
        resl = {
            'id': item.user.id,
            'majorId': item.major.id,
            'collegeId': item.college.id,
            'gradeId': item.grade.id,
        }

    return successData(resl)

def students_data_add(request):

    id = int(time.time())

    user = models.Users.objects.create(id = id,
                                userName=request.POST.get('userName'), passWord = request.POST.get('passWord'),
                                name=request.POST.get('name'), age = request.POST.get('age'),
                                gender=request.POST.get('gender'), type=request.POST.get('type'),
                                )

    models.Students.objects.create(user = user,
                                   major = models.Majors.objects.get(id=request.POST.get('majorId')),
                                   college = models.Colleges.objects.get(id=request.POST.get('collegeId')),
                                   grade = models.Grades.objects.get(id=request.POST.get('gradeId')),
                                   )

    return success()

def students_data_upd(request):

    models.Students.objects.filter(user__id = request.POST.get('id')).update(
                                                                    major=models.Majors.objects.get(id=request.POST.get('majorId')),
                                                                    college=models.Colleges.objects.get(id=request.POST.get('collegeId')),
                                                                    grade=models.Grades.objects.get(id=request.POST.get('gradeId')),
                                                                    )
    return success()

def students_data_del(request):
    models.Students.objects.filter(user__id = request.POST.get('id')).delete()
    models.Users.objects.filter(id=request.POST.get('id')).delete()
    return success()


def teachers_view(request):

    return render(request, "Teachers.html", {'reocrds': ['专科', '本科', '研究生', '其他']})

def teachers_data_page(request):
    pageIndex = request.GET.get('pageIndex', 1)
    pageSize = request.GET.get('pageSize', 10)
    teacherName = request.GET.get('teacherName')
    record = request.GET.get('record')
    phone = request.GET.get('phone')

    qruery = Q();

    if isExit(teacherName):
        qruery = qruery & Q(user__name__contains = teacherName)

    if isExit(record):
        qruery = qruery & Q(record = record)

    if isExit(phone):
        qruery = qruery & Q(phone = phone)


    data = models.Teachers.objects.filter(qruery)

    paginator = Paginator(data, pageSize)

    resl = []
    for item in list(paginator.page(pageIndex)):
        temp = {
            'id': item.user.id,
            'name': item.user.name,
            'age': item.user.age,
            'gender': item.user.gender,
            'record': item.record,
            'phone': item.phone,
            'address': item.address,
        }
        resl.append(temp)

    temp = parasePage(pageIndex, pageSize,
                      paginator.page(pageIndex).paginator.num_pages, paginator.count, resl)

    return successData(temp)

def teachers_data_info(request):

    id = request.GET.get('id')

    data = models.Teachers.objects.filter(user__id=id)

    resl = {}
    for item in data:
        resl = {
            'id': item.user.id,
            'record': item.record,
            'phone': item.phone,
            'address': item.address,
        }

    return successData(resl)

def teachers_data_add(request):

    user = models.Users.objects.create(id = int(time.time()),
                                userName=request.POST.get('userName'), passWord = request.POST.get('passWord'),
                                name=request.POST.get('name'), age = request.POST.get('age'),
                                gender=request.POST.get('gender'), type=request.POST.get('type')
                                )

    models.Teachers.objects.create(user = user, address = request.POST.get('address'),
                                   record=request.POST.get('record'), phone = request.POST.get('phone')
                                   )

    return success()

def teachers_data_upd(request):

    models.Teachers.objects.filter(user__id = request.POST.get('id')).update(
                                                                    address=request.POST.get('address'),
                                                                    record=request.POST.get('record'),
                                                                    phone=request.POST.get('phone')
                                                                    )
    return success()

def teachers_data_del(request):
    models.Teachers.objects.filter(user__id = request.POST.get('id')).delete()
    models.Users.objects.filter(id=request.POST.get('id')).delete()
    return success()


def work_view(request):

    return render(request, "TeacherWorks.html")

def work_data_list(request):

    user = request.session.get('user')

    workPlans = models.WorkPalns.objects.filter(teacher__user__id = user['id'])

    resl = []

    for item in workPlans:

        temp = {
            'id': item.id,
            'projectName': item.project.name,
            'gradeName': item.grade.name,
        }
        resl.append(temp)

    return successData(resl)

def work_data_add(request):

    models.WorkPalns.objects.create(id=int(time.time()),
                                     teacher=models.Teachers.objects.get(user__id=request.POST.get('teacherId')),
                                     grade=models.Grades.objects.get(id=request.POST.get('gradeId')),
                                     project=models.Projects.objects.get(id=request.POST.get('projectId')),
                                     )
    return success()



def select_view(request):
    user = request.session.get('user')

    if user['type'] == 0:

        grades = models.Grades.objects.all().values()
        projects = models.Projects.objects.all().values()

        return render(request, "SelectLogs.html", {'grades': grades, 'projects': projects})
    elif user['type'] == 1:

        grades = models.Grades.objects.all().values()
        return render(request, "StudentLogs.html", {'grades': grades})
    elif user['type'] == 2:

        return render(request, "ProjectLogs.html")

def select_data_page(request):
    pageIndex = request.GET.get('pageIndex', 1)
    pageSize = request.GET.get('pageSize', 10)
    teacherName = request.GET.get('teacherName')
    studentName = request.GET.get('studentName')
    gradeId = request.GET.get('gradeId')
    projectId = request.GET.get('projectId')

    qruery = Q(student__isnull = False);

    if isExit(teacherName):
        qruery = qruery & Q(workPaln__teacher__user__name__contains=teacherName)

    if isExit(studentName):
        qruery = qruery & Q(student__user__name__contains=studentName)

    if isExit(gradeId):
        qruery = qruery & Q(workPaln__grade__id__contains=gradeId)

    if isExit(projectId):
        qruery = qruery & Q(workPaln__project__id__contains=projectId)

    data = models.SelectLogs.objects.filter(qruery)

    paginator = Paginator(data, pageSize)

    resl = []
    for item in list(paginator.page(pageIndex)):

        temp = {
            'id': item.id,
            'projectName': item.workPaln.project.name,
            'gradeName': item.workPaln.grade.name,
            'teacherId': item.workPaln.teacher.user.id,
            'teacherName': item.workPaln.teacher.user.name,
            'studentId': item.student.user.id,
            'studentName': item.student.user.name,
        }
        resl.append(temp)

    temp = parasePage(pageIndex, pageSize,
                      paginator.page(pageIndex).paginator.num_pages, paginator.count, resl)

    return successData(temp)

def selec_data_student_select(request):

    user = request.session.get('user')

    student = models.Students.objects.filter(user__id = user['id']).first()

    workPlans = models.WorkPalns.objects.filter(grade__id = student.grade.id)

    resl = []

    for item in workPlans:

        isSelected = models.SelectLogs.objects.filter(student__user__id = user['id'] , workPaln__id = item.id).count() > 0

        temp = {
            'id': item.id,
            'projectName': item.project.name,
            'teacherName': item.teacher.user.name,
            'teacherGender': item.teacher.user.gender,
            'teacherRecord': item.teacher.record,
            'isSelected': isSelected
        }
        resl.append(temp)

    return successData(resl)

def selec_view_student_selected(request):

    return render(request, "StudentProjects.html")

def select_data_teastudent_page(request):

    user = request.session.get('user')

    pageIndex = request.GET.get('pageIndex', 1)
    pageSize = request.GET.get('pageSize', 10)
    studentName = request.GET.get('studentName')
    gradeId = request.GET.get('gradeId')
    projectId = request.GET.get('projectId')

    qruery = Q(workPaln__teacher__user__id = user['id']) & Q(student__isnull = False);

    if isExit(studentName):
        qruery = qruery & Q(student__user__name__contains=studentName)

    if isExit(gradeId):
        qruery = qruery & Q(workPaln__grade__id__contains=gradeId)

    if isExit(projectId):
        qruery = qruery & Q(workPaln__project__id__contains=projectId)

    data = models.SelectLogs.objects.filter(qruery)

    paginator = Paginator(data, pageSize)

    resl = []
    for item in list(paginator.page(pageIndex)):

        print(item)

        temp = {
            'id': item.id,
            'projectName': item.workPaln.project.name,
            'gradeName': item.workPaln.grade.name,
            'studentName': item.student.user.name,
            'studenGender': item.student.user.gender,
            'studenColleges': item.student.college.name,
            'studenMajors': item.student.major.name,
        }
        resl.append(temp)

    temp = parasePage(pageIndex, pageSize,
                      paginator.page(pageIndex).paginator.num_pages, paginator.count, resl)

    return successData(temp)

def selec_data_student_selected(request):

    user = request.session.get('user')

    selectLogs = models.SelectLogs.objects.filter(student__user_id = user['id'])

    resl = []

    for item in selectLogs:

        temp = {
            'id': item0.id,
            'projectName': item.workPaln.project.name,
            'teacherName': item.workPaln.teacher.user.name,
            'teacherGender': item.workPaln.teacher.user.gender,
            'teacherRecord': item.workPaln.teacher.record,
        }
        resl.append(temp)

    return successData(resl)

def selec_view_student_selected(request):

    return render(request, "StudentProjects.html")

def select_data_add(request):

    user = request.session.get('user')

    models.SelectLogs.objects.create(id = int(time.time()),
                                     student=models.Students.objects.get(user__id=user['id']),
                                     workPaln=models.WorkPalns.objects.get(id=request.POST.get('planId')),
                                    )
    return success()