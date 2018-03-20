module AppAPI
  module Entities
    class UserSimple < Base
      # public attributes
      expose_id
      expose_created_at
      expose :nickname, documentation: { desc: '用户昵称' }
      expose :display_headshot, as: :headshot, documentation: { desc: '头像' }
      if Settings.project.imolin?
        expose :description, documentation: {desc: '个性签名'}
      end
    end
  end
end
