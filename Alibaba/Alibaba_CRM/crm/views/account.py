from django.shortcuts import HttpResponse, render, redirect, reverse
from django.http import JsonResponse
from crm import models
from crm.forms import Registered
from django.views.decorators.csrf import ensure_csrf_cookie
import hashlib

def index(request):
    return render(request, 'index.html')

# 注册
def registered(request):
    form_obj = Registered()
    if request.method == 'POST':
        # 如果是post请求,将post数据添加进form对象中
        form_obj = Registered(data=request.POST)
        # 判断是否通过校验,添加进数据库
        if form_obj.is_valid():
            # 打印通过校验的清洗过的数据
            # print(form_obj.cleaned_data)
            # 将清洗后数据添加进数据库,方法1,由于re_password在数据库中没这字段,所有从clean_data中弹出
            # form_obj.cleaned_data.pop('re_password')
            # cleaned_data是字典,打散写入表
            # models.UserProfile.objects.create(**form_obj.cleaned_data)

            # 将清洗后数据添加进数据库,方法2,一步到位
            form_obj.save()

    return render(request, 'registered.html', {'form_obj': form_obj})


# 登录认证
@ensure_csrf_cookie
def login(request):
    err_msg = ''
    if request.method == 'POST':
        user = request.POST.get('user')
        pwd = request.POST.get('pwd')
        md5 = hashlib.md5()
        md5.update(pwd.encode('utf-8'))
        enc_pwd = md5.hexdigest()
        exist_obj = models.UserProfile.objects.filter(username=user, password=enc_pwd, is_active=True).first()
        if exist_obj:
            # 登录成功后,设置用户pk值作为session值,提供给中间件即公私户使用
            request.session['user_id'] = exist_obj.pk
            jump_data = {'jump_addr': '/index/'}
            return JsonResponse(jump_data)

        err_msg = '用户名或密码错误!'
        return HttpResponse(err_msg)
    return render(request, 'login.html', {'err_msg': err_msg})


# 注销
def logout(request):
    request.session.flush()
    return redirect(reverse('login'))
