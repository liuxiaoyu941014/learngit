module AppAPI
  module Entities
    class SiteRecommend < Base
      expose_id
      expose :name, documentation: { desc: "产品名称" }
      expose :image_url, documentation: { desc: '产品图片' }
      expose :redirect_web_url, documentation: { desc: '跳转到web的链接' }
      expose :redirect_app_url, documentation: { desc: '跳转到app的链接' }
      expose :headshots, documentation: { is_array: true }

      def image_url
        object.image_items.map(&:image_url).first
      end

      def redirect_web_url
        Settings.site.host + '/agent/products/' + object.id.to_s
      end

      def redirect_app_url
        Settings.site.host + '/v1/products/' + object.id.to_s
      end

      def headshots
        if object.favorites.blank?
          ::User.all.limit(5).map(&:display_headshot)
        else
          object.favorites.limit(5).map{|favorite| favorite.user.display_headshot}
        end
      end
    end
  end
end
