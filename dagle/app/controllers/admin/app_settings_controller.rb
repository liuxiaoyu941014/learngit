# csv support
require 'csv'
class Admin::AppSettingsController < Admin::BaseController
  before_action :set_app_setting, only: [:show, :edit, :update, :destroy, :used]

  # GET /admin/app_settings
  def index
    authorize AppSetting
    @filter_colums = %w(id)
    @app_settings = build_query_filter(AppSetting.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@app_settings.to_json, filename: "app_settings-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@app_settings.to_xml, filename: "app_settings-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@app_settings.as_csv(), filename: "app_settings-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/app_settings/1
  def show
    authorize @app_setting
  end

  # GET /admin/app_settings/new
  def new
    authorize AppSetting
    @app_setting = AppSetting.new
  end

  # GET /admin/app_settings/1/edit
  def edit
    authorize @app_setting
  end

  # POST /admin/app_settings
  def create
    authorize AppSetting
    @app_setting = AppSetting.new(permitted_attributes(AppSetting))

    if @app_setting.save
      redirect_to admin_app_setting_path(@app_setting), notice: "#{AppSetting.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/app_settings/1
  def update
    authorize @app_setting
    if @app_setting.update(permitted_attributes(@app_setting))
      redirect_to admin_app_setting_path(@app_setting), notice: "#{AppSetting.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/app_settings/1
  def destroy
    authorize @app_setting
    @app_setting.destroy
    redirect_to admin_app_settings_url, notice: "#{AppSetting.model_name.human} 删除成功."
  end

  def used
    authorize @app_setting
    if AppSetting.update_all(active: false) && @app_setting.update_attributes(active: true)
      redirect_to admin_app_settings_url, notice: "#{@app_setting.name} 方案使用成功."
    else
      render js: "alert('出现错误')"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_setting
      @app_setting = AppSetting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_app_setting_params
    #       #   params[:admin_app_setting]
    #       # end
end
