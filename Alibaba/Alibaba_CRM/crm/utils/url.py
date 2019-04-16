from django.urls import reverse


# 自定义一个反向解析过滤器;
# 将request->将其传过来的url参数(id,查询条件,分页)进行urlencode;
# name->url别名;*args, **kwargs->上述参数

def reverse_url(request, name, *args, **kwargs):
    # 反向解析获得url地址
    base_url = reverse(name, args=args, kwargs=kwargs)
    # urlencode将其参数编码拼接
    params = request.GET.urlencode()
    # 如果不含参数,则直接返回url地址就好
    if not params:
        return base_url
    # 含有参数,将参数与url拼接上127.0.0.1:80/list?page=10
    return "{}?{}".format(base_url, params)


# 优化后代码,原因:编辑私户时还跳转到公户
def rev(request, name, *args, **kwargs):
    # 反向解析获得url地址
    base_url = reverse(name, args=args, kwargs=kwargs)
    # GET获取next中的路径参数
    next_url = request.GET.get('next')
    # 没获取到就返回原路径
    if not next_url:
        return base_url
    # 有就返回获取的路径
    return  next_url
