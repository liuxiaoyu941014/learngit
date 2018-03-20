module AppAPI::V1
  class ImageItem < Grape::API
    helpers AppAPI::SharedParams
    resources :image_items do

      desc "图片上传" do
        success AppAPI::Entities::ImageItem
      end
      # swagger 无法测试多图上传
      # 可以用如下方法测试
      # curl -X POST --header 'Content-Type: multipart/form-data' --header 'Accept: application/json'
      #  -F images[][file]=@"logo.png"  'http://api.lvh.me:5000/v1/image_items'
      params do
        if Settings.project.imolin?
          optional :images, type: Array
          optional :file, :type => Rack::Multipart::UploadedFile, :desc => "单图片上传"
        else
          requires :images, type: Array do
            requires :file, :type => Rack::Multipart::UploadedFile, :desc => "多图片上传"
          end
        end
      end
      post do
        authenticate!
        if params[:file]
          image = ::ImageItem.create(image: ActionDispatch::Http::UploadedFile.new(params[:file]), owner: current_user)
          present image, with: AppAPI::Entities::ImageItem
        elsif params[:images]
          images = []
          if Settings.project.imolin?
            params[:images].each do |image|
              StringIO.open(Base64.decode64(image)) do |data|
                data.class.class_eval { attr_accessor :original_filename, :content_type }
                data.original_filename = "headshot.jpg"
                data.content_type = "image/jpeg"
                image = ::ImageItem.create(image: data, owner: current_user)
                images << image
              end
            end
          else
            params[:images].each do |file|
              images << ::ImageItem.create(image: ActionDispatch::Http::UploadedFile.new(file[:file]), owner: current_user)
            end
          end
          present images, with: AppAPI::Entities::ImageItem       
        end 
      end

    end # end of resources
  end
end
