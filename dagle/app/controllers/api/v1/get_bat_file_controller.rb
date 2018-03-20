class  Api::V1::GetBatFileController < ApplicationController
  # before_action :authenticate!

  def index
    order = Order.find(params[:order_id])
    source_path = order.resource_url
    description_path  = "C:\\Users\\%username%\\Desktop\\CV_migration_script"
    text = "xcopy #{source_path} #{description_path} /s/d \n\nstart #{description_path} \n\nmsg %username% /time:5 '已经将所需文件复制到:#{description_path} 目录下．' \n\ndel %0"
    send_data(text, filename: "#{order.code}.bat")
  end
end
