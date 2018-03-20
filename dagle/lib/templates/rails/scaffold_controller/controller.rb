<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < <%= controller_class_name.split('::').size > 1 ? "#{controller_class_name.split('::')[0]}::BaseController" : 'ApplicationController' %>
  before_action :set_<%= model_var_name %>, only: [:show, :edit, :update, :destroy]

  def index
    authorize <%= model_class_name %>
    @<%= plural_model_var_name %> = <%= model_class_name %>.all.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render json: @<%= plural_model_var_name %> }
    end
  end

  def show
    authorize @<%= model_var_name %>
    respond_to do |format|
      format.html
      format.json { render json: @<%= model_var_name %> }
    end
  end

  def new
    authorize <%= model_class_name %>
    @<%= model_var_name %> = <%= model_class_name %>.new(<%= model_var_name %>_params)
  end

  def edit
    authorize @<%= model_var_name %>
  end

  def create
    authorize <%= model_class_name %>
    @<%= model_var_name %> = <%= model_class_name %>.new(permitted_attributes(<%= model_class_name %>)))

    respond_to do |format|
      format.html do
        if @<%= model_var_name %>.save
          redirect_to <%= singular_table_name %>_path(@<%= model_var_name %>), notice: <%= "'#{human_name} 创建成功.'" %>
        else
          render :new
        end
      end
      format.json { render json: @<%= model_var_name %> }
    end

  end

  def update
    authorize @<%= model_var_name %>
    respond_to do |format|
      format.html do
        if @<%= model_var_name %>.update(permitted_attributes(@<%= model_var_name %>))
          redirect_to <%= singular_table_name %>_path(@<%= model_var_name %>), notice: <%= "'#{human_name} 更新成功.'" %>
        else
          render :edit
        end
      end
      format.json { render json: @<%= model_var_name %> }
    end
  end

  def destroy
    authorize @<%= model_var_name %>
    @<%= model_var_name %>.destroy
    respond_to do |format|
      format.html { redirect_to <%= index_helper %>_url, notice: <%= "'#{human_name} 删除成功.'" %> }
      format.json { head 200 }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= model_var_name %>
      @<%= model_var_name %> = <%= model_class_name %>.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{model_var_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= model_var_name %>]
      <%- else -%>
      params.require(:<%= model_var_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
