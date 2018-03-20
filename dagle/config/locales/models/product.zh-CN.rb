_, data = IO.read(__FILE__).split(/^__END__$/, 2)

site_name = Settings.project.meikemei? ? '美容院商家' : '商家'

YAML.load(ERB.new(data).result(binding))

__END__

---
zh-CN:
  activerecord:
    models:
      product: 产品
    attributes:
      product:
        site: <%= site_name %>
        catalog: 产品分类
        name: 产品名称
        image: 图片
        price: 原价
        responsive_person: 适应人群
        warning_message: 注意事项
        service_time: 服务时长
        month_number: 月单数
        unit: 库存单位
        stock: 库存
        discount: 优惠价
        weight: 产品重量
        weight_unit: 重量单位
        description: 简要描述
        content: 介绍
        hot: 热卖
        recommend: 推荐
        event: 活动
        promotion: 促销
        is_manager_recommend: 是否设为站长推荐
        is_shelves: 商品上架
        video_url: 视频链接
        date: 演出日期
        time: 演出时间
        address_line1: 地址1
        address_line2: 地址2
        phone: 联系方式
        can_purchase: 是否支持下单
        note: 备注
        statuses:
          pending: 未开始
          open: 进行中
          completed: 已满员/售完
          closed:  已结束/关闭
        maximum_for_one_account: 一个账号可以报几次名
        maximum_for_one_order: 一个订单最多可以报名人数
        member_attributes: 报名需要填写的属性
        reserve_datetime: 预定时间
        external_purchase_url: 外链地址
    errors:
      models:
        product:
  helpers:
    product:
