module AppAPI
  module Entities
    class CommunitySimple < Base

      # public attributes
      expose_id
      expose :name, documentation: { desc: '小区名称' }
      expose :address_lat, documentation: { desc: '小区纬度', type: Float }
      expose :address_lng, documentation: { desc: '小区经度', type: Float }
      expose :address_line, documentation: { desc: '小区地址'}
      expose_created_at
      expose_updated_at

    end
  end
end
