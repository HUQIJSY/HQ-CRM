from django.conf.urls import url
from crm.views import account
from crm.views import consultant
from crm.views import teacher


urlpatterns = [
    url(r'^login/', account.login, name='login'),
    url(r'^logout/', account.login, name='logout'),
    url(r'^registered/', account.registered, name='registered'),
    url(r'^index/', account.index),
    # 销售所需功能->客户/跟进记录/报名记录
    # 客户展示
    # 公户私户使用的视图函数是一个,筛选条件不同;但是路由分发还是使用单独的
    url(r'^customer_list/', consultant.Customer_list.as_view(), name='customer_list'),
    url(r'^my_customer/', consultant.Customer_list.as_view(), name='my_customer'),
    # 添加和编辑使用的视图函数是一个,只是参数区别;但是路由分发还是使用单独的
    url(r'^customer_add/', consultant.customer_change, name='customer_add'),
    url(r'^customer_change/(\d+)/$', consultant.customer_change, name='customer_change'),
    # 跟进记录,编辑添加复用同一view函数
    url(r'^consult_list/(?P<customer_id>\d+)', consultant.Consult_list.as_view(), name='consult_list'),
    url(r'^consult_add/', consultant.consult_add, name='consult_add'),
    url(r'^consult_edit/(\d+)/$', consultant.consult_edit, name='consult_edit'),
    # 报名表展示
    url(r'^enrollment_list/(?P<customer_id>\d+)', consultant.Enrollment_list.as_view(), name='enrollment_list'),
    # url(r'^enrollment_add/(?P<customer_id>\d+)', views.enrollment_add, name='enrollment_add'),
    # url(r'^enrollment_edit/(?P<record_id>\d+)', views.enrollment_edit, name='enrollment_edit'),
    # 添加编辑二合一
    url(r'^enrollment_add/(?P<customer_id>\d+)', consultant.enrollment_addedit, name='enrollment_add'),
    url(r'^enrollment_edit/(?P<record_id>\d+)', consultant.enrollment_addedit, name='enrollment_edit'),

    # 班主任所需功能->班级管理/课程管理/课程记录
    url(r'^class_list/', teacher.Class_list.as_view(), name='class_list'),
    url(r'^class_add/', teacher.class_change, name='class_add'),
    url(r'^class_edit/(?P<class_id>\d+)/', teacher.class_change, name='class_edit'),
    # 课程记录,执行显示当前班级的课程记录就好;没必要显示所有的,所有设置一个class_id参数;
    url(r'^course_record_list/(?P<class_id>\d+)/', teacher.Course_record_list.as_view(), name='course_record_list'),
    # 添加需要传一个班级id,目的是在班级展示中点击班级跳到当前班级课程记录展示,所以添加也就添加当前班级的课程记录就好
    url(r'^course_record_add/(?P<class_id>\d+)/', teacher.course_record_change, name='course_record_add'),
    url(r'^course_record_edit/(?P<record_id>\d+)/', teacher.course_record_change, name='course_record_edit'),
    # 学习记录,采用的是通过课程展示时批量创建,并需传入课程记录id,表示为哪个课程创建学习的记录
    url(r'^study_record_list/(?P<course_record_id>\d+)/', teacher.study_record_list, name='study_record_list'),
]
