class Agent::DiymenusController < Agent::BaseController
  before_action :set_site
  before_action :set_diymenu, only: [:show, :edit, :update, :destroy]

  # GET /diymenus
  def index
    @page_name = 'diymenus_index'
    @diymenus = @site.diymenus
  end

  # GET /diymenus/new
  def new
    @diymenu = @site.diymenus.new
  end

  # GET /diymenus/1/edit
  def edit
  end

  # POST /diymenus
  def create
    @diymenu = @site.diymenus.new(diymenu_params)

    if @diymenu.save
      redirect_to agent_diymenus_path, notice: '菜单创建成功.'
    else
      render :new
    end
  end

  # PATCH/PUT /diymenus/1
  def update
    if @diymenu.update(diymenu_params)
      redirect_to agent_diymenus_path, notice: '菜单修改成功.'
    else
      render :edit
    end
  end

  # DELETE /diymenus/1
  def destroy
    @diymenu.destroy
    redirect_to agent_diymenus_path, notice: '删除菜单成功.'
  end

  def sort
    state = JSON.parse(params[:state])
    enabled_menus, disabled_menus = state
    save_sorted_menus enabled_menus, true
    save_sorted_menus disabled_menus, false
    render json: {
      action: :sort 
    }
  end

  def upload_wx_menu
    result = @site.upload_wx_menu
    render json: {
      action: :upload_wx_menu,
      msg: JSON.parse(result.body)
    }
  end

  def download_wx_menu
    result = @site.download_wx_menu!
    render json: {
      action: :download_wx_menu,
      msg: result
    }
  end

  private

    def save_sorted_menus(state, enabled)
      Array(state).each_with_index do |parent_menu, i|
        parent_id = parent_menu['id']
        @site.diymenus.where(id: parent_id).update_all(parent_id: nil, is_show: enabled, sort: i)
        Array(parent_menu['children']).flatten.each_with_index do |sub_menu, j|
          @site.diymenus.where(id: sub_menu['id']).update_all(parent_id: parent_id, is_show: enabled, sort: j)
        end
      end
    end

    def set_site
      @site = Site.find_by!(user_id: current_user.id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_diymenu
      @diymenu = @site.diymenus.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def diymenu_params
      params.require(:diymenu).permit(:button_type, :name, :key, :url, :is_show, :sort)
    end
end
