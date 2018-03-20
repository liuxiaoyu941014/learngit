module AppAPI::V1
  class ChatMessage < Grape::API
    helpers AppAPI::SharedParams
    resources :messages do

      desc '聊天消息历史记录' do
        success AppAPI::Entities::ChatMessage.collection
      end
      params do
        use :pagination
        requires :room_id, type: Integer, desc: '频道ID'
      end
      get do
        # authenticate!
        messages = paginate_collection(::Chat::Message.where(room_id: params[:room_id]).order(created_at: :desc), params)
        wrap_collection messages, AppAPI::Entities::ChatMessage
      end

    end # end of resources
  end
end
