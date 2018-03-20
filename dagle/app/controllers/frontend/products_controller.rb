class Frontend::ProductsController < Frontend::BaseController
  acts_as_commentable resource: Product
  impressionist :actions=>[:show]
  acts_as_trackable user_id: :get_user_id, resource: :get_visit_resource, only: [:show]

  def index
    # 所有产品列表

  end

  def show
    # 当前产品详情
    @product = Product.find(params[:id])
    @comment_path = comments_frontend_product_path(@product)
    # @similar_products = Product.where(tag_list: @product.tag_list.to_s).limit(3)
  end
  

  private
    def get_user_id
      current_user && current_user.id
    end

    def get_visit_resource
      @product
    end
end
