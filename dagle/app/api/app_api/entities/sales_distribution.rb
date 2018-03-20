module AppAPI
  module Entities
    class SalesDistribution < Base
      # public attributes
      # expose_id
      expose_created_at
      expose :type_name, documentation: { desc: '分销类型' }
      expose :url, documentation: { desc: '分销链接' }
      expose :code, documentation: { desc: '分销码' }
      expose :user, using: AppAPI::Entities::UserSimple, documentation: { desc: '所属用户' }
    end
  end
end
