# csv support
require 'csv'
class Admin::CommentsController < Admin::BaseController
  before_action :set_admin_comment, only: [:show, :edit, :update, :destroy]

  # GET /admin/comments
  def index
    authorize Comment::Entry
    @filter_colums = %w(id)
    @admin_comments = Comment::Entry.all.order("created_at DESC").page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@admin_comments.to_json, filename: "admin_comments-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@admin_comments.to_xml, filename: "admin_comments-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@admin_comments.as_csv(only: []), filename: "admin_comments-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/comments/1
  def show
    authorize @admin_comment
  end

  # GET /admin/comments/new
  def new
    authorize Comment::Entry
    @admin_comment = Comment::Entry.new
  end

  # GET /admin/comments/1/edit
  def edit
    authorize @admin_comment
  end

  # POST /admin/comments
  def create
    authorize Comment::Entry
    @admin_comment = Comment::Entry.new(permitted_attributes(Comment::Entry))

    if @admin_comment.save
      redirect_to admin_comment_path(@admin_comment), notice: "#{Comment::Entry.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/comments/1
  def update
    authorize @admin_comment
    if @admin_comment.update(permitted_attributes(@admin_comment))
      redirect_to admin_comment_path(@admin_comment), notice: "更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/comments/1
  def destroy
    authorize @admin_comment
    @admin_comment.destroy
    redirect_to admin_comments_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_comment
      @admin_comment = Comment::Entry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_comment_params
    #       #   params[:admin_comment]
    #       # end
end
