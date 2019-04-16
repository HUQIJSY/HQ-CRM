class Pagination:
    # 前端获取当前页->page
    # 获取总数据量->all_count
    # 每页显示15条数据,设置默认参数->per_num
    # 最多显示多少页,设置默认参数->max_show

    def __init__(self, page, all_count, parmas, per_num=15, max_show=11):
        try:
            page = int(page)
            if page <= 0:
                page = 1
        except Exception as e:
            page = 1
        self.page = page
        self.all_count = all_count
        self.per_num = per_num
        self.max_show = max_show
        # 获取查询条件的QueryDict->parmas
        self.parmas = parmas
        # 总页码数
        self.page_num, more = divmod(all_count, per_num)
        if more:
            self.page_num += 1
        # 最多显示页码数
        half_show = max_show // 2

        if self.page_num < max_show:
            # 总页码数不够 最大显示页码数
            self.page_start = 1
            self.page_end = self.page_num
        else:
            # 能显示超过最大显示页码数
            if page <= half_show:
                # 处理左边的极值
                self.page_start = 1
                self.page_end = max_show
            elif page + half_show > self.page_num:
                # 处理右边的极值
                self.page_start = self.page_num - max_show + 1
                self.page_end = self.page_num
            else:
                # 正常的情况
                self.page_start = page - half_show
                self.page_end = page + half_show

    @property
    def start(self):
        return (self.page - 1) * self.per_num

    @property
    def end(self):
        return self.page * self.per_num

    @property
    def page_html(self):
        li_list = []
        # 此处不用加self.parmas,因为是禁用状态了
        if self.page == 1:
            li_list.append('<li class="disabled" ><a> << </a></li>')
        else:
            # 给含有条件的QueryDict增加页码键值对page=i;然后在使用request.GET.urlencode()形成=>page=2&query=8
            self.parmas['page'] = self.page - 1
            li_list.append('<li ><a href="?{}"> << </a></li>'.format(self.parmas.urlencode()))

        for i in range(self.page_start, self.page_end + 1):
            self.parmas['page'] = i
            if self.page == i:
                li_list.append('<li class="active"><a href="?{0}">{1}</a></li>'.format(self.parmas.urlencode(), i))
            else:
                li_list.append('<li><a href="?{0}">{1}</a></li>'.format(self.parmas.urlencode(), i))

        if self.page == self.page_num:
            # 此处不用加self.parmas,因为是禁用状态了
            li_list.append('<li class="disabled" ><a> >> </a></li>')
        else:
            self.parmas['page'] = self.page + 1
            li_list.append('<li ><a href="?{}"> >> </a></li>'.format(self.parmas.urlencode()))

        return ''.join(li_list)
