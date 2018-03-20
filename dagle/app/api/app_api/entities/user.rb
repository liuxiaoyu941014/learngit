module AppAPI
  module Entities
    class User < UserSimple
      # private attributes
      with_options if: ->(user, options) { options[:type] == :private || options[:current_user].try(:id) == user.id } do |f|
        expose :username, documentation: { desc: '用户名：私有数据，自己或有特定权限的账号才能获得' }
        expose :email, documentation: { desc: '电子邮件：私有数据，自己或有特定权限的账号才能获得' }
        expose :mobile_phone, documentation: { desc: '私有数据，自己或有特定权限的账号才能获得' }
        expose :nickname, documentation: { desc: '用户名：私有数据，自己或有特定权限的账号才能获得' }
        if Settings.project.imolin?
          expose :current_community, using: AppAPI::Entities::CommunitySimple, documentation: {desc: '当前选中小区'}
          expose :gender, documentation: {desc: '性别'}
        end
        expose :display_headshot, as: :headshot, documentation: { desc: '头像' }
        if Settings.project.meikemei?
          expose :points, documentation: {desc: '用户积分'}

          def points
            object.orders.completed.sum(&:price).to_i/100
          end
        end
      end

      expose :access_token, if: :access_token, documentation: { desc: '用户身份，在注册或登录时返回' } do |user, options|
        options[:access_token]
      end

      if Settings.project.sxhop?
        expose :description, documentation: { desc: '用户自我介绍' }
        expose :site_favorites_count, documentation: { desc: '收藏的店铺数量，特定条件下才能获得', type: Integer }, if: ->(user, options) { options[:site_favorites_count] }

        expose :product_favorites_count, documentation: { desc: '收藏的产品数量，特定条件下才能获得', type: Integer }, if: ->(user, options) { options[:product_favorites_count] }

        # TODO: 分享的帖子数量，特定条件下才能获得
        expose :article_shares_count, documentation: { desc: '分享的帖子数量，特定条件下才能获得（功能未实现，始终返回0）', type: Integer }, if: ->(user, options) { options[:article_shares_count] }

        expose :shopping_carts_count, documentation: { desc: '购物车里商品的数量' }

        expose :share_code, documentation: { desc: '我的邀请码'}
        expose :share_url, documentation: { desc: '我的邀请链接'}

        def site_favorites_count
          object.site_favorites.count
        end

        def product_favorites_count
          object.product_favorites.count
        end

        def article_shares_count
          object.articles.count
        end

        def shopping_carts_count
          object.shopping_carts.sum(:amount)
        end

        def share_code
          ::SalesDistribution::Resource.find_by(user_id: object.id, type_name: '用户注册').try(:code)
        end

        def share_url
          "#{::SalesDistribution.route_prefix}#{share_code}"
        end
      end

      def mobile_phone
        object.mobile.try(:phone_number)
      end

    end
  end
end
