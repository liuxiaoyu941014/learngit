module AppAPI
  module Entities
    class ChatRoom < Base

      expose_id
      expose_created_at
      expose :name, documentation: { desc: '频道名称' }
      if Settings.project.imolin?
        expose :owner, using: AppAPI::Entities::CommunitySimple, documentation: { desc: '所属小区' }
        expose :user, using: AppAPI::Entities::UserSimple, documentation: {desc: '创建用户'}
      end
    end
  end
end
