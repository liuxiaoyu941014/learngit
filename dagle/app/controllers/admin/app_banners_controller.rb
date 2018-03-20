# csv support
require 'csv'
class Admin::AppBannersController < Admin::BaseController
  before_action :set_app_settings
  before_action :set_app_banner_article, only: [:show, :edit, :update, :destroy]

  # GET /admin/app_banners
  def index
    authorize AppSetting
    @app_banner_articles = Article.where(article_type: :banner).order(updated_at: :desc).page(params[:page])
  end

  # GET /admin/app_banners/1
  def show
    authorize AppSetting
  end

  # GET /admin/app_banners/new
  def new
    authorize AppSetting
    @app_banner_article = Article.new
  end

  # GET /admin/app_banners/1/edit
  def edit
    authorize AppSetting
  end

  # POST /admin/app_banners
  def create
    authorize AppSetting
    @app_banner_article = Article.new(description: params[:article][:description],title: params[:article][:title],article_type: :banner, author: current_user.id)
    if @app_banner_article.save
      redirect_to admin_app_setting_app_banners_path(@app_setting), notice: "创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/app_banners/1
  def update
    authorize AppSetting
    if @app_banner_article.update(description: params[:article][:description], title: params[:article][:title])
      redirect_to admin_app_setting_app_banners_path(@app_setting), notice: "更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/app_banners/1
  def destroy
    authorize AppSetting
    @app_banner_article.destroy
    redirect_to admin_app_setting_app_banners_path(@app_setting), notice: "删除成功."
  end

  def edit_banner
    authorize AppSetting
    @app_setting.app_data[params[:format]] = params[:app_setting]['src'].map{|k, v| {'src'=> v, 'url'=> params[:app_setting]['url'][k]}}.to_yaml
    if @app_setting.save
      redirect_to admin_app_setting_app_banners_path(@app_setting), notice: "修改成功."
    else
      redirect_to admin_app_setting_app_banners_path(@app_setting), notice: "修改失败."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_banner_article
      @app_banner_article = Article.where(article_type: :banner).find(params[:id])
    end

    def set_app_settings
      @app_setting     = AppSetting.find(params[:app_setting_id])
      @service_banners = begin YAML.load(@app_setting.service_banners) rescue [] end
      @main_banners    = begin YAML.load(@app_setting.main_banners) rescue [] end
    end
end
