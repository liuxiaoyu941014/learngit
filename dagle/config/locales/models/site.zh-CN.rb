_, data = IO.read(__FILE__).split(/^__END__$/, 2)

site_name = Settings.project.meikemei? ? '美容院' : (Settings.project.dagle? ? '经销商' : '商家')

YAML.load(ERB.new(data).result(binding))

__END__

---
zh-CN:
  activerecord:
    models:
      site: <%= site_name %>
    attributes:
      site:
        user_id: <%= site_name %>-所有者
        title: 名称
        business_hours: 营业时间
        address_line: 地址
        contact_phone: 联系电话
        contact_name: 联系人
        avg_price: 人均消费
        is_sign: 是否签约
        sign_note: 签约备注
        parent_id: 父级商家
        score: 星级评分
        comment: 营销备注
        description: 简要描述
        content: <%= site_name %>介绍
        good_summary: 好评数
        bad_summary: 差评数
        is_published: 是否发布
        parking: 停车
        business_area: 商圈
        lat: 纬度
        lng: 经度
        phone: 手机号
        contract_note: 签约备注
        is_flatform_recommend: 是否设为平台推荐
        delivery_fee: 订单配送费
        properties:
          assure: 正品保障
          cleaning: 卫生清洁
          hidden_consumption: 无隐性消费
          standard_procedure: 标准流程
    errors:
      models:
        site:
  helpers:
    site:
