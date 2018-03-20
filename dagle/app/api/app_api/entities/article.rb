module AppAPI
  module Entities
    class Article < ArticleSimple
      expose :description, documentation: { desc: '文章内容' }, if: ->(article, options) { options.fetch(:includes, []).map(&:to_s).include?('description') }
      if Settings.project.sxhop?
        expose :products_simple, as: :products, if: ->(article, options) { options[:type] == :list }
        expose :products, using: AppAPI::Entities::ProductSimple, documentation: { is_array: true }, if: ->(article, options) { options[:type] != :list }
      end
      if Settings.project.imolin?
        expose :comments, using: AppAPI::Entities::Comment, if: ->(article, options) { options.fetch(:includes, []).map(&:to_s).include?('comments') }
        expose :is_applied do |article, options|
          article.user_ids.include? options[:user_id]
        end
        expose :valid_time_begin, documentation: { desc: '公告有效期起始时间' }
        expose :valid_time_end, documentation: { desc: '公告有效期结束时间' }
        expose :article_type, documentation: { desc: '公告类型' }
        expose :is_top, documentation: { desc: '是否置顶' }
      end
      expose_updated_at

      def products_simple
        object.products.as_json(only: [:id, :name], methods: :price, include: { image_items: { only: [], methods: [:image_url]} })
      end

    end
  end
end
