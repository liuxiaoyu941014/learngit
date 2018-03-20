class Api::V1::PreorderConversitionsController < Api::BaseController
  before_action :authenticate!
  before_action :set_preorder_conversition, only: [:show, :update, :create_comment, :comments_index, :attachments_index]

  def index
    # authorize PreorderConversition
    page_size = params[:page_size] ? params[:page_size].to_i : 20
    preorder_conversitions = PreorderConversition.all.order(created_at: :desc)
    preorder_conversitions = preorder_conversitions.page(params[:page] || 1).per(page_size)
    render json: {
      preorder_conversition: preorder_conversition_json(preorder_conversitions),
      page_size: page_size,
      current_page: preorder_conversitions.current_page,
      total_pages: preorder_conversitions.total_pages,
      total_count: preorder_conversitions.total_count
    }
  end

  def create
    authorize PreorderConversition
    preorder_conversition = current_user.preorder_conversitions.new(permitted_attributes(PreorderConversition))
    if preorder_conversition.save
      render json: {status: 'ok', preorder_conversition: preorder_conversition_json(preorder_conversition)}
    else
      render json: {status: 'failed', error_message:  preorder_conversition.errors.full_messages }
    end
  end

  def show
    render json: {status: 'ok', preorder_conversition: preorder_conversition_json(@preorder_conversition)}
  end

  def update
    authorize PreorderConversition
    @preorder_conversition.update(factory_confirm: true)
    render json: {status: 'ok'}
  end

  def create_comment
    preorder_conversition_comment = @preorder_conversition.comments.new(params[:comment].permit(:content, :offer, :image_item_ids => [], :attachment_ids => []))
    preorder_conversition_comment.user = current_user
    if preorder_conversition_comment.save
      render json: {status: 'ok', comment: preorder_conversition_comment_json(preorder_conversition_comment)}
    else
      render json: {status: 'failed', error_message: preorder_conversition_comment.errors.full_messages.map{|x| x.gsub(/Content/, '回复内容')}}
    end
  end

  def comments_index
    page_size = params[:page_size] ? params[:page_size].to_i : 20
    total_pages = @preorder_conversition.comments.page(1).per(page_size).total_pages
    preorder_conversition_comments = @preorder_conversition.comments.order(created_at: :asc).page(params[:page] || total_pages).per(page_size)
    render json: {comments: preorder_conversition_comment_json(preorder_conversition_comments), current_page: preorder_conversition_comments.current_page, total_pages: preorder_conversition_comments.total_pages, total_count: preorder_conversition_comments.total_count}
  end

  def attachments_index
    attachments = @preorder_conversition.attachments
    render json: { attachments_id_name: attachments.as_json(only: [:id], methods: [:attachment_file_name]) }
  end

  private
    def preorder_conversition_json(preorder_conversitions)
      preorder_conversitions.as_json(only: [:id, :title, :content, :created_at], methods: [:member_id, :member_name, :member_phone, :site_confirm, :factory_confirm],
        include: {
          site: { only: [:id, :title]},
          user: { only: [:nickname]},
          orders: { only: [:id, :code] }
        }
      )
    end

    def set_preorder_conversition
      @preorder_conversition = PreorderConversition.find(params[:id])
    end

    def preorder_conversition_comment_json(comment)
      comment.as_json(
        only: [:content, :created_at], methods: [:offer],
        include: {
          user: { only: [:nickname, :id]},
          image_items: {only: [:id], methods: [:image_url, :image_file_name]},
          attachments: {only: [:id, :name], methods: [:attachment_url, :attachment_file_name]}
        }
      )
    end
end
