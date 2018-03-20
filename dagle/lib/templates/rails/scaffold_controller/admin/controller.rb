# csv support
require 'csv'
<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < Admin::BaseController
  before_action :set_<%= model_var_name %>, only: [:show, :edit, :update, :destroy]

  # GET <%= route_url %>
  def index
    authorize <%= model_class_name %>
    @filter_colums = %w(id)
    @<%= plural_model_var_name %> = build_query_filter(<%= orm_class.all(model_class_name) %>, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@<%= plural_model_var_name %>.to_json(only: []), filename: "<%= plural_model_var_name %>-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@<%= plural_model_var_name %>.to_xml(only: []), filename: "<%= plural_model_var_name %>-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@<%= plural_model_var_name %>.as_csv(only: []), filename: "<%= plural_model_var_name %>-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET <%= route_url %>/1
  def show
    authorize @<%= model_var_name %>
  end

  # GET <%= route_url %>/new
  def new
    authorize <%= model_class_name %>
    @<%= model_var_name %> = <%= orm_class.build(model_class_name) %>
  end

  # GET <%= route_url %>/1/edit
  def edit
    authorize @<%= model_var_name %>
  end

  # POST <%= route_url %>
  def create
    authorize <%= model_class_name %>
    @<%= model_var_name %> = <%= orm_class.build(model_class_name, "permitted_attributes(#{model_class_name})") %>

    if @<%= model_var_name %>.save
      redirect_to <%= singular_table_name %>_path(@<%= model_var_name %>), notice: "#{<%= model_class_name %>.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    authorize @<%= model_var_name %>
    if @<%= model_var_name %>.update(permitted_attributes(@<%= model_var_name %>))
      redirect_to <%= singular_table_name %>_path(@<%= model_var_name %>), notice: "#{<%= model_class_name %>.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    authorize @<%= model_var_name %>
    @<%= model_var_name %>.destroy
    redirect_to <%= index_helper %>_url, notice: "#{<%= model_class_name %>.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= model_var_name %>
      @<%= model_var_name %> = <%= orm_class.find(model_class_name, "params[:id]") %>
    end

    # Only allow a trusted parameter "white list" through.
    # def <%= "#{singular_table_name}_params" %>
    #   <%- if attributes_names.empty? -%>
    #   params[:<%= singular_table_name %>]
    #   <%- else -%>
    #   params.require(:<%= singular_table_name %>).permit(policy(@<%= singular_table_name %>).permitted_attributes)
    #   <%- end -%>
    # end
end
<% end -%>
