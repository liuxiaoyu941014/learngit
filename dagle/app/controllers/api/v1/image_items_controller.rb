class  Api::V1::ImageItemsController < Api::V1::BaseController
  before_action :authenticate!

  def create
    # authorize ImageItem
    flag, image_item = ImageItem::Create.({image: params["file"], owner: @current_user})
    if flag
      render json: {status: 'ok', type: 'image', image_item: image_item_json(image_item)}
    else
      render json: {status: 'failed', error_message:  image_item.errors.full_messages.join(', ') }
    end
  end

  private
  def image_item_json(image_item)
    image_item.as_json(only: %w(id name), methods: [:image_url, :image_file_name])
  end

end
