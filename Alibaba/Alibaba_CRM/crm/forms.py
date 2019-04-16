from django import forms
from django.core.validators import ValidationError
from crm import models
import hashlib


# 定义一个Bootstrap样式类,主要修改input框
class Bootstrap(forms.ModelForm):
    # 利用__init__中fields为多个字段添加插件
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # 获得一个有序字典orderDict
        # print(self.fields)
        for field in self.fields.values():
            # 利用字典更新update方法,不会对原有数据赋值
            field.widget.attrs.update({'class': 'form-control'})


# 用户注册,由于Bootstrap已经继承了forms.ModelsForm,直接继承它就可以使用ModelForm还有样式
class Registered(Bootstrap):
    # 利用__init__中fields为多个字段添加插件
    # def __init__(self, *args, **kwargs):
    #     super().__init__(*args, **kwargs)
    # 获得一个有序字典orderDict
    # print(self.fields)
    # for field in self.fields.values():
    # 利用字典更新update方法,不会对原有数据赋值
    # field.widget.attrs.update({'class': 'form-control'})

    # 确认密码,由于数据库没定义,所以自定义;由于widget只能写一个插件,再写min_length不行,所有重新写
    password = forms.CharField(widget=forms.PasswordInput(), label='密码', min_length=8,
                               error_messages={'required': '不能为空,必填', 'min_length': '密码长度最短8位'})
    re_password = forms.CharField(widget=forms.PasswordInput(), label='确认密码', min_length=8,
                                  error_messages={'required': '不能为空,必填', 'min_length': '密码长度最短8位'})

    class Meta:
        model = models.UserProfile
        # 获取models中所有字段
        fields = '__all__'
        # 过滤掉某些字段
        exclude = ['is_active']
        # 直接指定某些字段,就不需要使用'__all__'与exclude
        # fields = ['username', 'password']

        # 为多个label添加中文描述
        labels = {
            'username': '用户名',
            'password': '密码',
            'name': '真实姓名',
            'department': '部门',
            'mobile': '手机号',
        }

        # 为多个字段添加插件,form-control所有框都加,所有换一种写法,__init__
        widgets = {
            'password': forms.PasswordInput(),
        }

        # 添加错误信息
        error_messages = {
            'username': {
                'required': '不能为空,必填',
                'invalid': '格式错误',
            },
            # 由于上面重写了password,此处错误信息不生效
            'password': {
                'required': '不能为空,必填',
                'min_length': '密码长度最短8位'
            },
            'name': {
                'required': '不能为空,必填',
            }
        }

    # 定义全局钩子,校验密码/确认密码是否一致
    def clean(self):
        # cleaned_data->通过校验,清洗过的数据字典;'NoneType' object has no attribute 'encode'->所以默认值改为''
        password = self.cleaned_data.get('password', '')
        re_password = self.cleaned_data.get('re_password')
        # 如果一致,则把清洗过的数据字典返回
        if password == re_password:
            # 密码一致后,在进行MD5加密
            md5 = hashlib.md5()
            md5.update(password.encode('utf-8'))
            enc_pwd = md5.hexdigest()
            # 将清洗后数据字典中的password替换成密文的
            self.cleaned_data['password'] = enc_pwd
            return self.cleaned_data
        # 如果不一致,则在错误信息字典中添加错误信息,添加在re_password中,并抛出异常
        self.add_error('re_password', '两次密码不一致')
        raise ValidationError('密码不一致')


# 用户添加,由于Bootstrap已经继承了forms.ModelsForm,直接继承它就可以使用ModelForm还有样式
class CustomerAdd(Bootstrap):
    # 由于Bootstrap中为每一个标签都添加演示,course选择框添加出现问题,所有重写父类__init__
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['course'].widget.attrs = {}

    class Meta:
        model = models.Customer
        fields = '__all__'


# 记录表添加编辑
class Consult_change(Bootstrap):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['delete_status'].widget.attrs.pop('class')
        # print(self.instance.consultant)->ModelChoiceIterator
        # print(list(self.fields['customer'].choices))
        customers = [(i.pk, str(i)) for i in self.instance.consultant.customers.all()]
        customers.insert(0, ('', '----------'))
        self.fields['customer'].choices = customers

    class Meta:
        model = models.ConsultRecord
        fields = '__all__'


# 报名表添加编辑
class Enrollment_change(Bootstrap):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['delete_status'].widget.attrs.pop('class')
        self.fields['contract_agreed'].widget.attrs.pop('class')
        self.fields['contract_approved'].widget.attrs.pop('class')
        # 若提交过来的customer_id不为0显示选中的当前用户;否则显示所有
        if self.instance.customer_id != '0':
            # 进行限制customers选择框的客户数量(只需显示需填写报名表的用户就行);self.instance.customer->客户对象 记住:元组
            self.fields['customer'].choices = [((self.instance.customer_id), str(self.instance.customer))]
            # 进行限制班级选择框的数量(只显示当前用户所选的班级);通过customer对象进行多对多正向查询获得班级管理对象
            self.fields['enrolment_class'].choices = [(i.pk, str(i)) for i in self.instance.customer.class_list.all()]

    class Meta:
        model = models.Enrollment
        fields = '__all__'


# 班级添加编辑
class Class_change(Bootstrap):
    class Meta:
        model = models.ClassList
        fields = '__all__'


# 课程记录添加编辑
class Course_record_change(Bootstrap):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['has_homework'].widget.attrs.pop('class')
        # 限制班级为当前班级
        self.fields['re_class'].choices = [((self.instance.re_class_id), str(self.instance.re_class))]
        # 限制班主任为当前到时
        self.fields['teacher'].choices = [((self.instance.teacher_id), str(self.instance.teacher))]

    class Meta:
        model = models.CourseRecord
        fields = '__all__'


# 学习记录展示
class Study_record_list(Bootstrap):
    class Meta:
        model = models.StudyRecord
        fields = '__all__'
