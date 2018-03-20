module AppAPI
  module Entities
    class SiteSimple < Base
      # public attributes
      expose_id
      expose :title, documentation: { desc: "#{::Site.model_name.human}名称" }
      expose :description, documentation: { desc: "#{::Site.model_name.human}详细描述" }, if: ->(site, options) { options[:type] == :full_site}
      expose :image_items, using: AppAPI::Entities::ImageItemSimple, as: :images, documentation: { is_array: true }

      if Settings.project.imolin?
        expose :comments_count, documentation: { desc: '评论数', type: Integer}
        expose :site_catalog_name, documentation: { desc: '分类名称', type: String}
        expose :avg_price
        expose :address_line, documentation: { desc: '地址' }
        expose :business_hours, documentation: { desc: '营业时间' }
        expose :phone, documentation: { desc: '联系电话' }
        expose :distance, documentation: { desc: '商家与小区之间的距离'}, if: ->(site, options) { options.fetch(:includes, []).map(&:to_s).include?('distance') }
      end

      if Settings.project.sxhop?
        expose :shares_count, documentation: { desc: '分享帖', type: Integer }
        expose :friends_count, documentation: { desc: '好友数', type: Integer }
        expose :favorites_count, documentation: { desc: '被私藏数', type: Integer }
      end

      if Settings.project.meikemei?
        expose :address_line, documentation: { desc: '地址' }
        expose :available_phone, as: :phone, documentation: { desc: '联系电话' }
        expose :business_hours, documentation: { desc: '营业时间' }
        expose :distance, documentation: { desc: '商家之间的距离'}, if: ->(site, options) { options.fetch(:includes, []).map(&:to_s).include?('distance') }
      end

      expose :user, using: AppAPI::Entities::UserSimple

      private
      def shares_count
        object.products.joins(:articles).count
      end

      def friends_count
        object.friends.count
      end

      def favorites_count
        object.favorites.count
      end

      def comments_count
        if Settings.project.imolin?
          object.orders.sum(&:comments_count)
        else
          object.products.sum(&:comments_count)
        end
      end

      def site_catalog_name
        object.catalog.try(:name)
      end

    end
  end
end
