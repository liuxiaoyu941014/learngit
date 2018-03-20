class Cms::CommentsController < Cms::BaseController
  before_action :set_cms_site
  before_action :set_cms_comment, only: [:show, :edit, :update, :destroy]

  def index
    authorize Cms::Comment
    @cms_comments = @cms_site.comments.order("id desc").page(params[:page])
    respond_to do |format|
      format.html
      format.json { render json: @cms_comments }
    end
  end

  def show
    authorize @cms_comment
    respond_to do |format|
      format.html
      format.json { render json: @cms_comment }
    end
  end

  def new
    authorize Cms::Comment
    @cms_comment = Cms::Comment.new(cms_comment_params)
  end

  def edit
    authorize @cms_comment
  end

  def create
    authorize Cms::Comment
    @cms_comment = @cms_site.comments.new(permitted_attributes(Cms::Comment))

    respond_to do |format|
      format.html do
        if @cms_comment.save
          redirect_to cms_site_comments_url(@cms_site), notice: ' 创建成功.'
        else
          render :new
        end
      end
      format.json { render json: @cms_comment }
    end

  end

  def update
    authorize @cms_comment
    respond_to do |format|
      format.html do
        if @cms_comment.update(permitted_attributes(@cms_comment))
          redirect_to cms_site_comments_url(@cms_site), notice: ' 更新成功.'
        else
          render :edit
        end
      end
      format.json { render json: @cms_comment }
    end
  end

  def destroy
    authorize @cms_comment
    @cms_comment.destroy
    respond_to do |format|
      format.html { redirect_to cms_site_comments_url(@cms_site), notice: ' 删除成功.' }
      format.json { head 200 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_comment
      @cms_comment = Cms::Comment.find(params[:id])
    end

    def set_cms_site
      @cms_site = Cms::Site.find(params[:site_id])
    end
    # Only allow a trusted parameter "white list" through.

end
