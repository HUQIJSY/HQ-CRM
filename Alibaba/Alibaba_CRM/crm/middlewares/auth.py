from django.utils.deprecation import MiddlewareMixin
from django.shortcuts import redirect, reverse
from crm import models

class Authentication(MiddlewareMixin):
    def process_request(self, request):
        # 此两条判断,是因为登录admin页面是,没有session值,就不要跳转到login页面了
        if request.path_info.startswith('/admin/'):
            return
        # 此条要练习底下的redirect(reverse('login')),如果没有session值,那么就重定向login;那就还得走中间件;若没此判断,则一直重定向报错
        if request.path_info in [reverse('login'), reverse('registered')]:
            return
        # 获取session值,session是用pk设置的
        pk = request.session.get('user_id')
        user = models.UserProfile.objects.filter(pk=pk).first()
        # 如果session存在把user赋给request.account,私户显示用;否则重定向到登录页面
        if user:
            request.account = user
        else:
            return redirect(reverse('login'))