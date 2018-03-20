module AppAPI::V1
  class ForageDetail < Grape::API
    resources :forage_details do
      desc "导入forage detail数据"
      params do
        requires :title, type: String, desc: '标题'
        requires :url, type: String, desc: '链接'
        requires :simple_id, type: Integer, desc: 'simple_id'
        optional :migrate_to, type: String, desc: '合并到'
        optional :can_purchase, type: String, desc: '是否支持下单'
        optional :purchase_url, type: String, desc: '下单地址'
        optional :keywords, type: String, desc: '关键词'
        optional :image, type: String, desc: '图片　'
        optional :description, type: String, desc: '描述'
        optional :content, type: String, desc: '内容'
        optional :date, type: String, desc: '日期'
        optional :time, type: String, desc: '时间'
        optional :address_line1, type: String, desc: '地址１'
        optional :address_line2, type: String, desc: '地址２'
        optional :phone, type: String, desc: '联系方式'
        optional :price, type: String, desc: '价格'
        optional :from, type: String, desc: '来源'
        optional :site_name, type: String, desc: '场馆名'
        optional :note, type: String, desc: '备注'
        optional :original_catalog, type: String, desc: '原始分类'
        optional :district_from, type: String, desc: '地区'
      end
      post do
        if Settings.project.wgtong?
          message = {}
          begin
            forage_detail = ::Forage::Detail.new(title: params[:title], url: params[:url])
            forage_detail.migrate_to = params[:migrate_to]
            forage_detail.can_purchase = params[:can_purchase]
            forage_detail.purchase_url = params[:purchase_url]
            forage_detail.keywords = params[:keywords]
            forage_detail.image = params[:image]
            forage_detail.description = params[:description]
            forage_detail.content = params[:content]
            forage_detail.date = params[:date]
            forage_detail.time = params[:time]
            forage_detail.address_line1 = params[:address_line1]
            forage_detail.address_line2 = params[:address_line2]
            forage_detail.phone = params[:phone]
            forage_detail.price = params[:price]
            forage_detail.from = params[:from]
            forage_detail.site_name = params[:site_name]
            forage_detail.note = params[:note]
            forage_detail.original_catalog = params[:original_catalog]
            forage_detail.district_from = params[:district_from]
            forage_detail.simple_id = params[:simple_id]
            forage_detail.save
            message[:flag] = true
          rescue => e
            message[:errors] = e.message
            message[:flag] = false
          end
          present message: message
        else
          present notice: "只能wgtong使用"
        end
      end
    end
  end
end
