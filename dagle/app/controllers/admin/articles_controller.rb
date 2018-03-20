# csv support
require 'csv'
class Admin::ArticlesController < Admin::BaseController
  before_action :set_community
  before_action :set_article, only: [:show, :edit, :update, :destroy, :recommend]

  # GET /admin/articles
  def index
    authorize Article
    @filter_colums = %w(id title)
    @articles = if @community.blank?
      Article.system
    else
      @community.articles
    end
    @articles = build_query_filter(@articles, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@articles.to_json, filename: "articles-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@articles.to_xml, filename: "articles-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@articles.as_csv(), filename: "articles-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/articles/1
  def show
    authorize @article
  end

  # GET /admin/articles/new
  def new
    authorize Article
    @article = Article.new
  end

  # GET /admin/articles/1/edit
  def edit
    authorize @article
  end

  # POST /admin/articles
  def create
    authorize Article
    @article = Article.new(permitted_attributes(Article).merge(community_id: @community.try(:id), author: current_user.id))
    @article.article_type = @community ? 'community' : 'system'

    if @article.save
      redirect_to @community ? admin_community_article_path(@community, @article) : admin_article_path(@article), notice: "#{Article.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/articles/1
  def update
    authorize @article
    if @article.update(permitted_attributes(@article))
      redirect_to @community ? admin_community_article_path(@community, @article) : admin_article_path(@article), notice: "#{Article.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/articles/1
  def destroy
    authorize @article
    @article.destroy
    redirect_to @community ? admin_community_articles_url : admin_articles_url, notice: "#{Article.model_name.human} 删除成功."
  end

  def recommend
    authorize @article
    if @article.update_attributes(is_flatform_recommend: !@article.is_flatform_recommend)
      render json: {status: 'ok', recommend: @article.is_flatform_recommend, message: "设置成功"}
    else
      render js: "alert('出现错误')"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = if @community.blank?
        Article.find(params[:id])
      else
        @community.articles.find(params[:id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_article_params
    #       #   params[:admin_article]
    #       # end
    def set_community
      @community = Community.where(id: params[:community_id]).first
    end
end
