class Api::V1::VendorsController < Api::BaseController
  before_action :authenticate!
  before_action :set_vendor, only: [:show, :destroy, :update]

  def index
    # authorize Vendor
    page_size = params[:page_size].present? ? params[:page_size].to_i : 20
    vendors = params['name'].present? ? Vendor.all.where("name_py like :key OR name like :key", {key: ['%',params['name'].upcase, '%'].join}) : Vendor.all
    vendors = vendors.order(created_at: :desc).page(params[:page] || 1).per(page_size)
    render json: {
      vendors: vendor_json(vendors),
      page_size: page_size,
      current_page: vendors.current_page,
      total_pages: vendors.total_pages,
      total_count: vendors.total_count
    }
  end

  def create
    authorize Vendor
    flag, vendor = Vendor::Create.(permitted_attributes(Vendor))
    if flag
      render json: {status: 'ok', vendor: vendor_json(vendor)}
    else
      render json: {status: 'failed', error_message:  vendor.errors.full_messages.join(', ') }
    end
  end

  def show
    # authorize @vendor
    render json: {status: 'ok', vendor: vendor_json(@vendor)}
  end

  def update
    authorize @vendor
    flag, vendor = Vendor::Update.(@vendor, permitted_attributes(Vendor))
    if flag
      render json: {status: 'ok', vendor: vendor_json(vendor)}
    else
      render json: {status: 'failed', error_message:  vendor.errors.full_messages.join(', ') }
    end
  end

  def destroy
    authorize @vendor
    if @vendor.destroy
      render json: {status: 'ok'}
    else
      render json: {status: 'failed', error_message: '出错了!'}
    end
  end

  private

  def set_vendor
    @vendor = Vendor.find(params[:id])
  end

  def vendor_json(vendor)
    vendor.as_json(
      only: %w(id name),
      methods: %w(phone_number contact_name)
    )
  end
end
