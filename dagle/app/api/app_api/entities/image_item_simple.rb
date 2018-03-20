module AppAPI
  module Entities
    class ImageItemSimple < Base
      expose :image_url, documentation: { desc: '图片链接' }
    end
  end
end
