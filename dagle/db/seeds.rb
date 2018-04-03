# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def create_if_not_exist(assoc, hash)
  rec = assoc.find_or_initialize_by(hash)
  if rec.new_record?
    rec.save!
    yield rec
  end
  rec
end

%w(super_admin admin agent).each do |name|
  create_if_not_exist Role, name: name do |rec|
    puts "创建用户/权限: " + name
  end
end

unless User.find_by_phone_number('18080810818')
  puts "创建用户: 管理员"
  _, admin = User::Create.(mobile_phone: '18080810818', nickname: '管理员', password: 'abcd1234', email: 'admin@tanmer.com', relname: '小红', cardnu: '511028199612126789', birth: '2010-10-12', locity: '四川成都', sex: '男')
  admin.save!
  raise "创建的第一个用户ID不等于1!!!" unless admin.id == 1
  admin.add_role :admin
  admin.add_role :super_admin
end

unless User.find_by_phone_number('15983288999')
  puts "创建用户: 商家"
  _, agent = User::Create.(mobile_phone: '15983288999', nickname: '商家', password: 'abcd1234', email: 'admin@tanmer.com', relname: '小红', cardnu: '511028199612126789', birth: '2010-10-12', locity: '四川成都', sex: '男')
  agent.add_role :agent
end

unless User.find_by_phone_number('15328077520')
  puts "创建用户: 用户"
  _, user = User::Create.(mobile_phone: '15328077520', nickname: '用户', password: 'abcd1234', email: 'admin@tanmer.com', relname: '小红', cardnu: '511028199612126789', birth: '2010-10-12', locity: '四川成都', sex: '男')
end

# 测试账号，方便app审核时测试用，手机号验证码是000000，在settings.xx.yml中有设置
unless User.find_by_phone_number('13900000000')
  puts "创建用户: 测试账号"
  _, user = User::Create.(mobile_phone: '13900000000', nickname: '测试账号', password: 'xhkafhsafl', email: 'admin@tanmer.com', relname: '小红', cardnu: '511028199612126789', birth: '2010-10-12', locity: '四川成都', sex: '男')
end

unless User.find_by_phone_number('11000000000')
  flag, public_admin = User::Create.(mobile_phone: '11000000000', nickname: '超级管理员', email: 'admin@tanmer.com', password: 'tanmer.com', relname: '小红', cardnu: '511028199612126789', birth: '2010-10-12', locity: '四川成都', sex: '男' )
  if flag
    puts "创建用户: 超级管理员"
    public_admin.save!
    public_admin.add_role :admin
    public_admin.add_role :super_admin
  else
    puts "公共超级管理员创建失败"
  end
end

site = Site.create_with(user: admin, address_line: '成都市成华区二环路东二段龙湖三千城').find_or_create_by!(title: '官网')
raise "创建的第一个商家ID不等于1!!!" unless site.id == 1

if Settings.project.dagle?
  # 德格角色
  # 总经销商，厂长，库管员，设计，工人，拆单员（物料分配）, 采购
  %w(product_manager factory_manager storekeeper designer worker allocator purchase).each do |name|
    create_if_not_exist Role, name: name do |rec|
      puts "创建角色: " + name
    end
  end
end

#系统参数
Keystore.put('cms_template_names', "['default','dagle','app-landing-spotlight','grand','eshop','newshub','student2']")

# init Cms
# visit: http://localhost:3000/cms_1/

create_if_not_exist Cms::Site.create_with(
  name: '企业官网',
  domain: 'www',
  # 这里如果不是文广通，newshub模版中就缺少Product.hot方法，所以做个判断。
  template: Settings.project.wgtong? ? 'newshub' : 'default',
  description: '这是用CMS搭建的官网'), site_id: site.id do |cms_site|
    puts "创建CMS官网"
  # Cms::Site 在创建时，会自动执行模版中的db_init.rb文件，所以这里不需要在创建channel和page
end

create_if_not_exist Cms::Site.create_with(
  name: '市民报名系统',
  domain: 'www',
  # 这里如果不是文广通，newshub模版中就缺少Product.hot方法，所以做个判断。
  template: Settings.project.smxx? ? 'student2' : 'default',
  description: '这是用CMS搭建的官网2'), site_id: site.id do |cms_site|
    puts "创建CMS官网2"
  # Cms::Site 在创建时，会自动执行模版中的db_init.rb文件，所以这里不需要在创建channel和page
end

if Settings.project.wgtong?
  %w(场馆 剧院 图书馆 社团 志愿者 其他).each do |name|
    create_if_not_exist SiteCatalog, name: name do
      puts '创建商家、社团分类:' + name
    end
  end

  %w(演出 讲座 展览 体育 培训 赛事 亲子 读书 音乐影视 其他).each do |name|
    create_if_not_exist ProductCatalog, name: name do
      puts '创建产品分类:' + name
    end
  end
end

if Settings.project.dagle?
  # 德格供应商
  %w(自购 舞东风 联合100 友达 顺丰 壹佰 盛世百龙 义力).each_with_index do |name, idx|
    create_if_not_exist Vendor.create_with(
      contact_name: "#{name}联系人", 
      phone_number: "139#{'0' * (8 - idx.to_s.length)}#{idx}"), name: name do
        puts "创建供应商:" + name
    end
  end

  # 创建仓库
  unless MaterialWarehouse.exists?(site_id: site.id)
    puts "创建初始仓库"
    MaterialWarehouse::Create.(site_id: site.id, name: '初始仓库')
  end

  # 德格物料分类 & 物料
  material_catalogs = {
    "柜体": [{'板材': []}, {'五金': []}, {'封边带': []}, {'纸箱': []}, {'气泡垫/珍珠棉': []}, {'油漆': []}, {'刀具': []}, {'封口胶': []}, {'胶': []}, {'旋转鞋柜': []}, {'密码抽': []}, {'反转床': []}, {'穿衣镜': []}],
    "移门": [{'五金': []}, {'皮纹/软包': []}, {'玻璃/腰线': []}, {'型材': []}],
    "平开门": [{'五金': []}, {'吸塑': []}]
  }
  material_catalogs.each_pair do |name_1, sub_name_pairs|
    create_if_not_exist MaterialCatalog, name: name_1 do |cata_1|
      puts "创建物料分类: #{name_1}" 
      sub_name_pairs.each do |sub_name_pair|
        sub_name_pair.each_pair do |name_2, _|
          create_if_not_exist MaterialCatalog, name: name_2, parent: cata_1 do |cata_2|
            puts "创建下级分类: #{name_2}"
            5.times do | index |
              create_if_not_exist Material.create_with(catalog: cata_2, site_id: site.id), name: "#{name_2}#{index + 1}" do |material|
                puts "创建物料: " + material.name
              end
            end
          end
        end
      end
    end
  end
end

# 客户
memberCatalogs = [
  {key: '客户级别', value: '{A类,B类,C类}'},
  {key: '会员关系', value: '{非会员,普通会员,银卡会员,金卡会员,至尊会员}'},
  {key: '客户性别', value: '{男,女}'},
  {key: '客户年龄', value: '{15-20,20-30,30-40,40-50,50-60}'},
  {key: '购买能力', value: '{一般,高,很高}'},
  {key: '客户活跃频次', value: '{很少,一般,高,很高}'}
]
memberCatalogs.each do |x|
  create_if_not_exist MemberCatalog, x do
    puts "创建客户分类: " + x.to_s
  end
end

# 营销页
%w(博客 活动 招商 会员拉新).each do |name|
  create_if_not_exist MarketCatalog, name: name do
    puts "创建营销页分类: " + name
    create_if_not_exist MarketTemplate.create_with(
      base_path: 'templetes/market/default',
      keywords: '营销页测试页',
      description: '这只是一个测试页面，可以实现类似一篇博客文章发布',
      image_path: '/templetes/market/default/previews/demo-1.png',
      html_source: '
        <html lang="zh-CN">
          <head>
            <meta charset="utf-8"/>
            <title><%= @market_page.name %></title>
            <meta content="<%= @market_page.description %>" name="description"/>
          </head>
          <body style="text-align: center;">
            <div style="margin: 0 auto; width:640px;">
              <h2><%= @market_page.value_for("title", title: "文章标题", typo: "string", default: "文章标题") %></h2><hr/>
              <div style="text-align:left;"><%= simple_format @market_page.value_for("content", title: "正文", typo: "text", default: "文章内容") %></div>
              <% @market_page.image_items.each do |img| %>
               <%= image_tag img.image_url, style: "width:100%;" %>
              <% end %>
            </div>
          </body>
        </html>'
    ), name: 'default', catalog_id: 1 do
      puts '创建营销页测试页'
    end
  end
end


if Settings.project.imolin?

  require 'roo'
  file_path= './db/init_data/communities.xlsx'
  worksheet = nil
  worksheet = Roo::Excelx.new(file_path)
  # ["uid", "name", "province", "city", "district", "street", "address", "telephone", "lat", "lng", "tags", "image", "keyword"]
  worksheet.row(1)
  2.upto worksheet.last_row do |index|
    c = Community.find_or_initialize_by(name: worksheet.row(index)[1])
    c.uid = worksheet.row(index)[0]
    c.province = worksheet.row(index)[2]
    c.city = worksheet.row(index)[3]
    c.district = worksheet.row(index)[4]
    c.street = worksheet.row(index)[5]
    c.address_str = worksheet.row(index)[6]
    c.telephone = worksheet.row(index)[7]
    c.lat = worksheet.row(index)[8]
    c.lng = worksheet.row(index)[9]
    c.tags = worksheet.row(index)[10]
    c.image = worksheet.row(index)[11]
    c.keyword = worksheet.row(index)[12]
    c.address_line = c.address_str.include?(c.name) ? c.address_str : c.address_str + ' ' + c.name
    c.save!
  end

  site_file_path= './db/init_data/site.xlsx'
  site_worksheet = nil
  site_worksheet = Roo::Excelx.new(site_file_path)
  # [shop_id, mall_id, verified, is_published, name, alias, province, city, city_pinyin, city_id, area, big_cate, big_cate_id, small_cate, small_cate_id, address, business_area, phone, hours, avg_price, stars, photos, description, tags, map_type, latitude, longitude, navigation, traffic, parking, characteristics, product_rating, environment_rating, service_rating, default_remarks, all_remarks, very_good_remarks, good_remarks, common_remarks, bad_remarks, very_bad_remarks, recommended_dishes, recommended_products, nearby_shops, is_chains, take-away, group, card, latest_comment_date]
  head = site_worksheet.row(1)
  2.upto site_worksheet.last_row do |index|
    c = Site.find_or_initialize_by(title: site_worksheet.row(index)[head.find_index('name')])
    c.is_published = !site_worksheet.row(index)[head.find_index('is_closed')]
    c.province = site_worksheet.row(index)[head.find_index('province')]
    c.city = site_worksheet.row(index)[head.find_index('city')]
    # c.area = site_worksheet.row(index)[head.find_index('area')]
    c.catalog = SiteCatalog.find_or_create_by_path([{name: site_worksheet.row(index)[head.find_index('big_cate')]},{name: site_worksheet.row(index)[head.find_index('small_cate')]}])
    c.address_line = c.province + c.city + site_worksheet.row(index)[head.find_index('address')] + ' ' + c.title
    c.business_area = site_worksheet.row(index)[head.find_index('business_area')]
    c.phone = site_worksheet.row(index)[head.find_index('phone')]
    c.business_hours = site_worksheet.row(index)[head.find_index('hours')]
    c.avg_price = site_worksheet.row(index)[head.find_index('avg_price')]
    c.photos = site_worksheet.row(index)[head.find_index('photos')]
    c.parking = site_worksheet.row(index)[head.find_index('parking')]
    c.recommendation = site_worksheet.row(index)[head.find_index('recommended_products')]
    c.good_summary = site_worksheet.row(index)[head.find_index('good_remarks')]
    c.bad_summary = site_worksheet.row(index)[head.find_index('bad_remarks')]
    c.properties = site_worksheet.row(index)[head.find_index('tags')]
    c.save!
  end
end
