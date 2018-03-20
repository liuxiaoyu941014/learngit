class AttachmentsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]

  def create
    flag, attachment = Attachment::Create.({attachment: params[:file], owner: current_user})
    if flag
      render json: {status: 'ok', attachment: attachment_json(attachment)}
    else
      render json: {status: 'failed', error_message: attachment.errors.messages.inject(''){ |k, v| k += v.join(':') + '. '}}
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    flag, @attachment = Attachment::Destroy.(@attachment, user: current_user)
    if flag
      render json: {status: 'ok'}
    else
      head 403
    end
  end

  private
  def attachment_json(attachment)
    attachment.as_json(only: %w(id name attachment_file_name attachment_url), methods: [:attachment_url, :attachment_file_name])
  end
end
