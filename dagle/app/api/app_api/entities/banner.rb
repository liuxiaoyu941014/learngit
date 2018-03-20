module AppAPI
  module Entities
    class Banner < Base

      # public attributes
      expose_id
      expose :image_url, documentation: { desc: '图片链接' }
      expose :redirect_web_url, documentation: { desc: '跳转到web的链接' }
      expose :redirect_app_url, documentation: { desc: '跳转到app的链接' }
    end
  end
end
