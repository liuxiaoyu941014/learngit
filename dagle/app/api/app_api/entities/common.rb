module AppAPI
  module Entities
    class Common < Base

      # public attributes
      expose_id
      expose :name, documentation: { desc: '名称' }
      expose_created_at
      expose_updated_at

    end
  end
end
