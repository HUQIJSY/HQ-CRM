from django import template
from django.urls import reverse
from django.http import QueryDict

register = template.Library()


# 自定义一个反向解析过滤器;
# 将request->将其传过来的url参数(id,查询条件,分页)进行urlencode;
# name->url别名;*args, **kwargs->上述参数page=10&query=1
@register.simple_tag()
def reverse_url(request, name,  *args, **kwargs):
    # 反向解析获得url地址
    base_url = reverse(name, args=args, kwargs=kwargs)
    # urlencode将其参数编码拼接
    params = request.GET.urlencode()
    # 如果不含参数,则直接返回url地址就好
    if not params:
        return base_url
    # 含有参数,将参数与url拼接上127.0.0.1:80/list?page=10&query=1
    return "{}?{}".format(base_url, params)


# 优化
@register.simple_tag()
def rev_url(request, name,  *args, **kwargs):
    # 反向解析获得url地址
    base_url = reverse(name, args=args, kwargs=kwargs)
    # 获取全路径+参数
    url = request.get_full_path()
    # 创建QueryDict对象,让其mutable=True可修改
    qd = QueryDict(mutable=True)
    # 在把路径参数添加进QueryDict字典对象中
    qd['next'] = url
    # 如果含参数,则直接返回url地址就好
    if  not next:
        return base_url
    # 含有参数,将参数编码成字符串与url拼接上127.0.0.1:80/list?page=10&query=1
    return "{}?{}".format(base_url, qd.urlencode())
