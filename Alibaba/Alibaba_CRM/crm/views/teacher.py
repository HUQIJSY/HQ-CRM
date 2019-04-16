from django.shortcuts import HttpResponse, render, redirect, reverse
from crm import models
from crm.forms import Class_change, Course_record_change, Study_record_list
from crm.utils.pagination import Pagination
from crm.utils.url import rev
from django.views import View
from django.db.models import Q
from django.db import transaction
from Alibaba_CRM import settings
from django.forms import modelformset_factory


# 班级展示列表
class Class_list(View):
    def get(self, request):
        classes = models.ClassList.objects.all()
        pager = Pagination(request.GET.get('page', 1), len(classes), request.GET.copy(), 2)
        return render(request, 'teacher/class_list.html',
                      {'classes': classes,
                       'all_classes': classes[pager.start:pager.end],
                       'page_html': pager.page_html})

    def post(self, request):
        action = request.POST.get('action')
        # 如果传过来的功能,后端不存在返回错误提示
        # print(action,request.POST.getlist('id'))
        if not hasattr(self, action):
            return HttpResponse('非法操作')
        # 否则获取功能方法并执行
        getattr(self, action)()
        # 操作完毕后,返回客户列表页面
        return self.get(request)


# 班级添加/编辑列表
def class_change(request, class_id=None):
    # 编辑获取对象
    inquire_obj = models.ClassList.objects.filter(pk=class_id).first()
    form_obj = Class_change(instance=inquire_obj)
    title = '编辑班级' if class_id else '添加班级'
    if request.method == 'POST':
        form_obj = Class_change(request.POST, instance=inquire_obj)
        if form_obj.is_valid():
            # 没有instance新增  有instance做修改
            form_obj.save()
            # 使用自定义reverse
            return redirect(rev(request, 'class_list', ))
        # 使用共同的添加编辑模板add_edit_form,只是form_obj title不同
    return render(request, 'add_edit_form.html', {'form_obj': form_obj, 'title': title})


# 课程记录展示;不需要再添加一个选项卡,直接让在班级名称上加a标签进行跳转到对应班级课程记录也可以传入班级id
class Course_record_list(View):
    def get(self, request, class_id=None):
        # re_class_id是CourseRecord的外键
        course_records = models.CourseRecord.objects.filter(re_class_id=class_id)
        pager = Pagination(request.GET.get('page', 1), len(course_records), request.GET.copy(), 2)
        return render(request, 'teacher/course_record_list.html',
                      {'course_records': course_records,
                       'all_records': course_records[pager.start:pager.end],
                       'page_html': pager.page_html,
                       # class_id在添加班级课程记录时,用的到;因为添加记录需要传入当前课程id
                       'class_id': class_id,
                       })

    def post(self, request, class_id=None):
        action = request.POST.get('action')
        if not hasattr(self, action):
            return HttpResponse('非法操作')
        res = getattr(self, action)()
        if res:
            return res
        return self.get(request, class_id)

    # 课程记录批量初始化->每个班级的(每天每节课)的记录时与学生关联的,就是说这个班的所有学生今天这节课学习记录都需要进行记录,可批量处理
    def multi_init(self):
        # 反射获取次方法后,由于前端勾选框设置的名字是name = "id",所以post获取勾选的所有课程记录id
        record_list = self.request.POST.getlist('id')
        # 通过获取的id,去课程记录表里获取响应课程记录id的对象列表record_obj_list
        record_obj_list = models.CourseRecord.objects.filter(id__in=record_list)
        # 迭代课程记录对象列表
        for record_obj in record_obj_list:
            # 通过课程记录对象,通过课程记录表的(班级外键)查到本节课对应的班级,
            # 再通过班级对象,可以从班级表里获知学生,学生表中设置了班级多对多关系,所有通过班级反向customer_set
            # 查出了对应班级的所有学生,在筛选出(学习中)状态的所有学生
            all_student = record_obj.re_class.customer_set.all().filter(status='studying')
            # 然后添加进数据库,向学习记录表(StudyRecord)中创建学生,课程记录对象

            # 此处选择批量创建进入数据库
            obj_list = []
            for student in all_student:
                # 先定义一个列表,装从数据库中查出来的学生对象,StudyRecord里有课程记录/学生字段;这是在内存中
                obj_list.append(models.StudyRecord(course_record=record_obj, student=student))
            # 然后把列表批量创建
            models.StudyRecord.objects.bulk_create(obj_list)


# 课程记录添加编辑
def course_record_change(request, class_id=None, record_id=None):
    # 添加时班级,老师进行显示,编辑是按照课程记录的id进行筛选
    obj = models.CourseRecord.objects.filter(pk=record_id).first() if record_id else models.CourseRecord(
        re_class_id=class_id, teacher=request.account)

    form_obj = Course_record_change(instance=obj)
    title = '添加课程记录' if class_id else '编辑课程记录'
    if request.method == 'POST':
        form_obj = Course_record_change(request.POST, instance=obj)
        if form_obj.is_valid():
            # 没有instance新增  有instance做修改
            form_obj.save()
            # 使用自定义reverse,course_record_list需要参数,所以三元表达式
            return redirect(rev(request, 'course_record_list', record_id if record_id else class_id))
        # 使用共同的添加编辑模板add_edit_form,只是form_obj title不同
    return render(request, 'add_edit_form.html', {'form_obj': form_obj, 'title': title})


# 学习记录展示
def study_record_list(request, course_record_id):
    # 采用formset工厂模式创建modelform_factory
    # 工厂模式需要models参数,forms参数,其他默认为None,extra默认为1,就是页面会默认显示一个空行,置位0就好
    Form_set = modelformset_factory(models.StudyRecord, Study_record_list,extra=0)
    # 通过课程记录id,去学习表中获取学生
    all_student = models.StudyRecord.objects.filter(course_record=course_record_id)
    # form_set->创建出来的是一个类,让查询出来的学生,作为参数传给queryset去创建form对象
    form_obj = Form_set(queryset=all_student)
    if request.method =='POST':
        form_obj = Form_set(request.POST, queryset=all_student)
        if form_obj.is_valid():

            form_obj.save()
            print(form_obj.errors)
    return render(request, 'teacher/study_record_list.html', {'form_obj': form_obj})
