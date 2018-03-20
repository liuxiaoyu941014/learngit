class  Api::V1::AttachmentsController < Api::V1::BaseController
  before_action :authenticate!

  def create
    authorize Attachment
    flag, attachment = Attachment::Create.({attachment: params["file"], owner: @current_user})
    if flag
      render json: {status: 'ok', type: 'attachment', attachment: attachment_json(attachment)}
    else
      render json: {status: 'failed', error_message:  attachment.errors.messages.inject(''){ |k, v| k += v.join(':') + '. '} }
    end
  end

  private
  def attachment_json(attachment)
    attachment.as_json(only: %w(id name), methods: [:attachment_url, :attachment_file_name])
  end

end
