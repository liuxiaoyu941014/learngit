class Agent::AssetsController < Agent::BaseController

  def index
    @images = []
    @images << get_ckeditor_assets.reverse
    @images << get_image_items_assets.reverse
    @images = Kaminari.paginate_array(@images.flatten.compact).page(params[:page]).per(20)

    respond_to do |format|
      format.html
      format.json do
        render json: @images
      end
    end
  end

  #内部图片资源合集
  def intranet_images
    @images = []
    @images << get_ckeditor_assets
    @images << get_image_items_assets
    @images = Kaminari.paginate_array(@images.flatten.compact).page(params[:page]).per(20)
    render json: @images
  end

  #外部图片资源合集
  def extranet_images
    render text: '未接入外部资源'
  end

  private
  def get_ckeditor_assets
     Dir.chdir(File.join(Rails.root, 'public', 'ckeditor_assets', 'pictures'))
     Dir.glob("*/*.jpg").select{|s| s. =~ /thumb/}.map{|s| '/ckeditor_assets/pictures/' + s }
  end

  def get_image_items_assets
    Dir.chdir(File.join(Rails.root, 'public', 'photos'))
    thumbfiles = File.join("**", "*thumb.")
    Dir.glob(thumbfiles).map{|s| '/photos/' + s}
  end
end
