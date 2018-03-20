# csv support
require 'csv'
class Admin::MaterialPurchasesController < Admin::BaseController
  before_action :set_material_purchase, only: [:show, :edit, :update, :destroy]

  # GET /admin/material_purchases
  def index
    authorize MaterialPurchase
    @material_purchases_all = MaterialPurchase.all
    if params[:code].present?
      @material_purchases_all = @material_purchases_all.where("code like ?", "%#{params[:code]}%")
    end
    if params[:q].present?
      @material_purchases_all = @material_purchases_all.where("code like ?", "%#{params[:q]}%")
    end
    if params[:vendor_name].present?
      @material_purchases_all = @material_purchases_all.joins(:vendor).where("items.name like ?", "%#{params[:vendor_name]}%")
    end
    if params[:search].present?
      if params[:search][:status].present?
        @material_purchases_all = @material_purchases_all.where(status: params[:search][:status])
      end
    end
    if params[:daterange].present?
      date_range = params["daterange"].split(' - ').map(&:strip).map(&:to_date)
      @material_purchases_all = @material_purchases_all.where("Date(material_purchases.created_at) in (?)", date_range[0]..date_range[-1])
    end
    @material_purchases = @material_purchases_all.includes(:vendor).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@material_purchases.to_json, filename: "material_purchases-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@material_purchases.to_xml, filename: "material_purchases-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@material_purchases.as_csv(), filename: "material_purchases-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
        format.json { render json: {:results => @material_purchases.as_json(only: [:id, :code]), :total => @material_purchases.size} }
      end
    end
  end

  # GET /admin/material_purchases/1
  def show
    authorize @material_purchase
  end

  # GET /admin/material_purchases/new
  def new
    authorize MaterialPurchase
    @material_purchase = MaterialPurchase.new
  end

  # GET /admin/material_purchases/1/edit
  def edit
    authorize @material_purchase
  end

  # POST /admin/material_purchases
  def create
    authorize MaterialPurchase
    @material_purchase = MaterialPurchase.new(permitted_attributes(MaterialPurchase))

    if @material_purchase.save
      redirect_to admin_material_purchase_path(@material_purchase), notice: "#{MaterialPurchase.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/material_purchases/1
  def update
    authorize @material_purchase
    if @material_purchase.update(permitted_attributes(@material_purchase))
      redirect_to admin_material_purchase_path(@material_purchase), notice: "#{MaterialPurchase.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/material_purchases/1
  def destroy
    authorize @material_purchase
    @material_purchase.destroy
    redirect_to admin_material_purchases_url, notice: "#{MaterialPurchase.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material_purchase
      @material_purchase = MaterialPurchase.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_material_purchase_params
    #       #   params[:admin_material_purchase]
    #       # end
end
