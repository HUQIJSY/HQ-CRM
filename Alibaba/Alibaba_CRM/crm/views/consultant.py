from django.shortcuts import HttpResponse, render, redirect, reverse
from crm import models
from crm.forms import CustomerAdd, Consult_change, Enrollment_change
from crm.utils.pagination import Pagination
from crm.utils.url import reverse_url, rev
from django.views import View
from django.db.models import Q
from django.db import transaction
from Alibaba_CRM import settings


# 客户列表展示
# def customer_list(request):
#     # 获取访问用户列表中url中的路径为customer_list->公户(销售为空的)
#     if request.path_info == '/customer_list/':
#         customers = models.Customer.objects.filter(consultant__isnull=True)
#     else:
#         # 否则,私户->获取登录此系统员工所负责的客户列表,所以筛选条件是员工的id(通过auth模块request.user获得)
#         # 但是request.user与admin客户的user冲突,改名为request.account(采用中间件中session值获得)
#         customers = models.Customer.objects.filter(consultant=request.account)
#     pager = Pagination(request.GET.get('page'), len(customers), per_num=15, max_show=11)
#     return render(request, 'customer_list.html',
#                   {'customers': customers, 'all_customerdata': len(customers), 'page_html': pager.page_html})


# 重写客户列表展示(CBV方式)
# 主要还是想通过面向对象的反射实现公私转换功能

class Customer_list(View, ):
    def get(self, request):
        print(request.GET.urlencode())
        # 定义查询字段,并传入查询的方法中获得q条件
        query_list = ['qq', 'name']
        q = self.search(query_list)
        if request.path_info == '/customer_list/':
            customers = models.Customer.objects.filter(q, consultant__isnull=True)
        else:
            # 否则,私户->获取登录此系统员工所负责的客户列表,所以筛选条件是员工的id(通过auth模块request.user获得)
            # 但是request.user与admin客户的user冲突,改名为request.account(采用中间件中session值获得)
            customers = models.Customer.objects.filter(q, consultant=request.account)
            # request.GET->QueryDict<'query':['8']> request.GET.copy()->Querydict深拷贝一份传值给分页类
        pager = Pagination(request.GET.get('page', 1), len(customers), request.GET.copy(), 2)
        return render(request, 'consultant/customer_list.html',
                      {'customers': customers, 'all_customerdata': customers[pager.start:pager.end],
                       'page_html': pager.page_html})

    def post(self, request):
        action = request.POST.get('action')
        # 如果传过来的功能,后端不存在返回错误提示
        # print(action,request.POST.getlist('id'))
        if not hasattr(self, action):
            return HttpResponse('非法操作')
        # 否则获取功能方法并执行,获取反射回来的返回值
        res = getattr(self, action)()
        # 如果res=None,调用自己的get方法(上边那个),重新render(customer_list.html);否则返回错误页面
        if res:
            return res
        # 操作完毕后,返回客户列表页面
        return self.get(request)

    # 公->私
    def multi_private(self):
        # 存在问题:多用户同时操作相同客户,会出现数据混乱<同时更改会成为后者私户后来者居上>
        # 解决问题:加锁(添加事务),当一个用户(销售)先勾选了客户,提交post请求后,对所选数据加锁,然后进行处理
        # 方法1:
        # 获取POST中的被选中的客户id,进行orm操作
        customer_ids = self.request.POST.getlist('id')
        # 可能选择多个用户(getlist),判断pk值在不在过的的列表中,在则update到数据库(缺陷代码)
        # models.Customer.objects.filter(pk__in=customer_ids).update(consultant=self.request.account)
        # (优化代码)加锁; select_for_update()加锁代码
        if self.request.account.customers.all().count() + len(customer_ids) > settings.MAX_CUSTOMER_NUM:
            return HttpResponse('做人不能太贪心了')

        with transaction.atomic():
            # 先将用户(销售)选定的客户通过customer_ids查询出来,加上锁 注:筛选条件是要筛选那些销售为空的客户
            queryset = models.Customer.objects.filter(pk__in=customer_ids, consultant__isnull=True).select_for_update()
            # 加锁锁后,并不是马上提交orm操作,而是判断你勾选的客户数量和你从客户表里查询出来加锁的客户数量是否相同(不相同,说明加锁的客户有被速度快的先拿走了)
            if len(customer_ids) == queryset.count():
                # 一样就把加锁的客户列表中对象的销售更新为当前销售
                queryset.update(consultant=self.request.account)
                # 如果操作成功返回None,不成功回复Httpresponse->反射的getattr()
                return
            return HttpResponse('你的手速太慢了!')

        # 方法2:
        # self.request.account->员工对象(通过session获得的见公私列表);通过反向查询customers(related_name);查询客户列表进行打散赋值添加到销售私表
        # self.request.account.customers.add(*models.Customer.objects.filter(pk__in=customer_ids))

    # 私->公
    def multi_public(self):
        # 方法1:
        # 获取POST中的被选中的客户id,进行orm操作
        customer_ids = self.request.POST.getlist('id')
        # 可能选择多个用户(getlist),判断pk值在不在过的的列表中,在则将其销售置为None
        models.Customer.objects.filter(pk__in=customer_ids).update(consultant=None)

        # 方法2:
        # 销售对象通过反向查询客户使用remove方法删除掉客户对象
        # self.request.account.customers.remove(*models.Customer.objects.filter(pk__in=customer_ids))

    # 模糊查询Q方法
    def search(self, query_list):
        # 获取GET请求中的query值
        query = self.request.GET.get('query', '')
        # 创建一个Q对象
        q = Q()
        q.connector = 'OR'  # OR/AND(默认)/NOT
        # 迭代传入的条件列表,进行字符串拼接
        for i in query_list:
            q.children.append(Q(('{}__contains'.format(i), query)))
        return q


# 用户添加及编辑
# 两者合并后,主要区别是编辑需要获取用户id,查询数据库获得源数据展示在input上,所以url添加分组,传入参数(设为None)
def customer_change(request, customer_id=None):
    # 若customer_id为None则url没有传id->添加;如果有值则进行数据库查询
    inquire_obj = models.Customer.objects.filter(pk=customer_id).first()
    # modelForm提供了一个instance方法,可直接将查询到的对象中原始数据添加到input上,若为none就不填
    # print(inquire_obj)
    form_obj = CustomerAdd(instance=inquire_obj)

    if request.method == 'POST':
        form_obj = CustomerAdd(request.POST, instance=inquire_obj)
        if form_obj.is_valid():
            # 没有instance新增  有instance做修改
            form_obj.save()
            # 使用自定义reverse
            return redirect(rev(request, 'customer_list', ))
    return render(request, 'consultant/customer_change.html', {'form_obj': form_obj, 'customer_id': customer_id})


# 跟进记录展示
class Consult_list(View):
    def get(self, request, customer_id):
        # 如果customer_id是'0'则显示所有
        if customer_id == '0':
            consult_objs = models.ConsultRecord.objects.filter(consultant=request.account)
        else:
            # customer_id->外键
            consult_objs = models.ConsultRecord.objects.filter(customer_id=customer_id)
        return render(request, 'consultant/consult_list.html', {'consult_objs': consult_objs})

    def post(self, request):
        pass


def consult_add(request):
    # 实例化一个含有销售的记录对象;传入forms对象中;主要是因为forms中获取不到request
    obj = models.ConsultRecord(consultant=request.account)
    form_obj = Consult_change(instance=obj)
    if request.method == 'POST':
        form_obj = Consult_change(request.POST, instance=obj)
        if form_obj.is_valid():
            form_obj.save()
            return redirect(reverse('consult_list', args=('0',)))
    return render(request, 'consultant/consult_add.html', {'form_obj': form_obj})


# 跟进记录添加/编辑
def consult_edit(request, consult_id=None):
    inquire_obj = models.ConsultRecord.objects.filter(pk=consult_id).first()
    form_obj = Consult_change(instance=inquire_obj)
    if request.method == 'POST':
        form_obj = Consult_change(request.POST, instance=inquire_obj)
        if form_obj.is_valid():
            form_obj.save()
            return redirect(reverse('consult_list', args=('0',)))
    return render(request, 'consultant/consult_edit.html', {'form_obj': form_obj, 'consult_id': consult_id})


# 报名表
class Enrollment_list(View):
    def get(self, request, customer_id):
        # 由url中获取的id参数为字符串类型;如果customer_id是'0'则显示所有
        if customer_id == '0':
            all_enrollments = models.Enrollment.objects.filter(customer__in=request.account.customers.all())
        # 否则会显示选择的客户
        else:
            all_enrollments = models.Enrollment.objects.filter(customer_id=customer_id)
        return render(request, 'consultant/enrollment_list.html', {'all_enrollments': all_enrollments})


# 报名表添加
# def enrollment_add(request, customer_id):
#     print(customer_id, type(customer_id))
#     # customer_id外键;利用获得的客户id实例化一个客户对象传入Forms,进行限制customers选择框的客户数量(只需显示需填写报名表的用户就行)
#     obj = models.Enrollment(customer_id=customer_id)
#     form_obj = Enrollment_change(instance=obj)
#     if request.method == 'POST':
#         form_obj = Enrollment_change(request.POST, instance=obj)
#         if form_obj.is_valid():
#             form_obj.save()
#             return redirect(reverse('enrollment_list', args=('0',)))
#     return render(request, 'enrollment_addedit.html', {'form_obj': form_obj, 'title': '填写报名表'})


# 报名表编辑
# def enrollment_edit(request, record_id):
#     inquire_obj = models.Enrollment.objects.filter(pk=record_id).first()
#     form_obj = Enrollment_change(instance=inquire_obj)
#     if request.method == 'POST':
#         form_obj = Enrollment_change(request.POST, instance=inquire_obj)
#         if form_obj.is_valid():
#             form_obj.save()
#             return redirect(reverse('enrollment_list', args=('0',)))
#     return render(request, 'enrollment_addedit.html', {'form_obj': form_obj, 'title': '编辑报名表'})


# 报名表添加/编辑二合一
# 参数既有添加的也有编辑的,都设置为默认参数
def enrollment_addedit(request, customer_id=None, record_id=None):
    # 方式1:if判断
    # 如果传过来的是customer_id,走添加
    # if customer_id:
    #     obj = models.Enrollment(customer_id=customer_id)
    #     title = '填写报名表'
    # else:
    #     obj = models.Enrollment.objects.filter(pk=record_id).first()
    #     title = '编辑报名表'
    # 方式2:三元表达式
    obj = models.Enrollment(customer_id=customer_id) if customer_id else models.Enrollment.objects.filter(
        pk=record_id).first()
    form_obj = Enrollment_change(instance=obj)
    if request.method == 'POST':
        form_obj = Enrollment_change(request.POST, instance=obj)
        if form_obj.is_valid():
            form_obj.save()
            return redirect(reverse('enrollment_list', args=('0',)))
    # return render(request, 'enrollment_addedit.html', {'form_obj': form_obj, 'title': title})
    # 方式2:三元表达式
    return render(request, 'consultant/enrollment_addedit.html',
                  {'form_obj': form_obj, 'title': '填写报名表' if customer_id else '编辑报名表'})
