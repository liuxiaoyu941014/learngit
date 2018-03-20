module AppAPI
  module Entities
    class ChatMessage < Base

      expose_id
      expose_created_at
      expose :text, documentation: { desc: '聊天信息' }
      expose :user, using: AppAPI::Entities::UserSimple
    end
  end
end
