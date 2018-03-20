# csv support
require 'csv'
class Admin::Cms::CommentsController < Admin::BaseController
  before_action :set_cms_comment, only: [:show, :edit, :update, :destroy]

  # GET /admin/cms/comments
  def index
    authorize Cms::Comment
    @filter_colums = %w(id)
    @cms_comments = build_query_filter(Cms::Comment.all, only: @filter_colums).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@cms_comments.to_json, filename: "cms_comments-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@cms_comments.to_xml, filename: "cms_comments-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@cms_comments.as_csv(only: []), filename: "cms_comments-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/cms/comments/1
  def show
    authorize @cms_comment
  end

  # GET /admin/cms/comments/new
  def new
    authorize Cms::Comment
    @cms_comment = Cms::Comment.new
  end

  # GET /admin/cms/comments/1/edit
  def edit
    authorize @cms_comment
  end

  # POST /admin/cms/comments
  def create
    authorize Cms::Comment
    @cms_comment = Cms::Comment.new(permitted_attributes(Cms::Comment))

    if @cms_comment.save
      redirect_to admin_cms_comment_path(@cms_comment), notice: "#{Cms::Comment.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/cms/comments/1
  def update
    authorize @cms_comment
    if @cms_comment.update(permitted_attributes(@cms_comment))
      redirect_to admin_cms_comment_path(@cms_comment), notice: "#{Cms::Comment.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/cms/comments/1
  def destroy
    authorize @cms_comment
    @cms_comment.destroy
    redirect_to admin_cms_comments_url, notice: "#{Cms::Comment.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_comment
      @cms_comment = Cms::Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_cms_comment_params
    #       #   params[:admin_cms_comment]
    #       # end
end
