class  Api::V1::DeliveriesController < Api::V1::BaseController
  before_action :authenticate!

  def index
    # authorize Attachment
    deliveries = Delivery.where(site_id: [params[:site_id], Site::MAIN_ID])
    render json: deliveries.as_json(only: %w(name id), methods: %w(phone_number address), include: { site: { only: [:title] } })
  end

  def create
    flag, delivery = Delivery::Create.(permitted_attributes(Delivery))
    if flag
      render json: {status: 'ok', delivery: delivery.as_json(only: [:id, :name], methods: [:address, :phone_number], include: {site: {only: :title}})}
    else
      render json: {status: :failed, error_message: delivery.errors}
    end
  end

  private
  # def attachment_json(attachment)
  #   attachment.as_json(only: %w(id name), methods: [:attachment_url, :attachment_file_name])
  # end

end
