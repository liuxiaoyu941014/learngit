module AppAPI
  module Entities
    class Discover < Base

      # public attributes
      expose :resource_data, documentation: { desc: '内容' }

      private
      def resource_data
        if object.resource.class.to_s == 'Product'
          object.resource.as_json(only: [:id, :name, :updated_at, :comments_count, :favorites_count, :visits_count, :likes_count, :sales_count], methods: [:first_image], include: { site: { only: [:title], include: { image_items: { only: [], methods: [:image_url] } } } }).merge(discover_type: 'product')
        else
          object.resource.as_json(only: [:id, :title, :description], methods: [:api_created_at], include: { user: { only: [:nickname], methods: [:display_headshot] }, image_items: { only: [], methods: [:image_url] }, products: { only: [:id, :name], methods: [:first_image] } }).merge(discover_type: 'article')
        end
      end
    end
  end
end
