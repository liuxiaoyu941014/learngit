class Api::V1::OrderCvsController < Api::BaseController
  before_action :authenticate!
  # before_action :set_orders, only: [:index]
  before_action :set_order, only: [:index, :create]

  def index
    order_cvs = @order.order_cvs
    render json: { order_cvs: order_cv_json(order_cvs) }
  end

  def create
    authorize OrderCv
    flag, message, order_cvs = parse_order_cv_upload_file
    if flag
      @order.update(internal_status: 'packing', update_by: current_user.id)
      render json: {status: 'ok'}
    else
      render json: {status: 'failed', error_message: message }
    end
  end

  private
    def parse_order_cv_upload_file
      require 'roo'
      message = ""
      all_upload = true
      order_cvs = []
      worksheet = nil
      file_path = params["file"].path
      if File.extname(file_path) == ".xlsx"
        worksheet = Roo::Excelx.new(file_path)
      elsif File.extname(file_path) == ".xls"
        worksheet = Roo::Excel.new(file_path)
      elsif File.extname(file_path) == ".csv"
        worksheet = Roo::CSV.new(file_path)
      end
      # ["柜体号", "柜体名称", "宽度", "高度", "深度", "部件名称", "长度", "宽度", "厚度", "材料名称", "类型", "条码信息", "数量", "单位", "订单号", "订单名称", "客户名称", "客户地址", "联系人", "联系电话", "下单时间", "发货时间", "邮政编码"]
      if worksheet
        title = worksheet.row(1)
        generate_time = worksheet.row(2)
        header = worksheet.row(3)
        if header[0..22].join(',') == "柜体号,柜体名称,宽度,高度,深度,部件名称,长度,宽度,厚度,材料名称,类型,条码信息,数量,单位,订单号,订单名称,客户名称,客户地址,联系人,联系电话,下单时间,发货时间,邮政编码" &&
          title.join(',') =~ /打包软件对接清单/ && generate_time.join(',') =~ /^\d{4}\/\d{1,2}\/\d{1,2}\s*\d{1,2}:\d{1,2}:\d{1,2}/
          # order = Order.find(params[:order_id])

          OrderCv.transaction do
            4.upto worksheet.last_row do |index|
              # .row(index) will return the row which is a subclass of Array
              row = worksheet.row(index)

              attributes = {
                cabinet_no: row[0],
                cabinet_name: row[1],
                order: @order
              }

              features = {}

              features['width'] = row[2]
              features['height'] = row[2]
              features['depth'] = row[4]
              features['component_name'] = row[5]
              features['component_length'] = row[6]
              features['component_width'] = row[7]
              features['component_depth'] = row[8]
              features['material_name'] = row[9]
              features['material_type'] = row[10]
              features['code'] = row[11]
              features['amount'] = row[12]
              features['unit'] = row[13]

              attributes["features"] = features

              flag, order_cv = OrderCv::Create.(attributes)
              if flag
                order_cvs.push(order_cv)
              else
                order_cv.errors.messages.each_pair do |k, v|
                  message += order_cv.send(k) +':'+ v.join(':')
                end
                all_upload = false
                raise ActiveRecord::Rollback
                break
              end
            end
          end
        else
          all_upload = false
          message = '列名不正确，请按照模版内列名填写！'
        end
      else
        all_upload = false
        message = '文件格式不正确！'
      end

      [all_upload, message, order_cvs]
    end

    def order_cv_json(order_cvs)
      order_cvs.as_json(
        only: [:id, :cabinet_no, :cabinet_name],
        methods: %w(width height depth component_name component_length component_width component_depth material_name material_type code amount unit),
        include: {
          order: {only: [:id, :code]}
        }
      )
    end

    def set_order
      @order = Order.find(params[:order_id])
    end
end
