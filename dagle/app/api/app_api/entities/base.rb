module AppAPI
  module Entities
    class Base < Grape::Entity

      format_with(:timestamp) do |time|
        time.to_i
      end

      def self.expose_id
        expose :id, documentation: { type: Integer }
      end

      def self.expose_created_at
        expose :created_at, documentation: { type: Integer, desc: '数据创建时间' }, format_with: :timestamp
      end

      def self.expose_updated_at
        expose :updated_at, documentation: { type: Integer, desc: '数据修改时间' }, format_with: :timestamp
      end

      def self.collection(meta: true)
        klass_name = "#{self.name.split('::').last}Collection"
        klass_name = "#{klass_name}WithoutMeta" unless meta
        return self.const_get(klass_name) if self.const_defined? klass_name
        klass = Class.new(Grape::Entity)

        code = <<-RUBY.strip_heredoc
          def self.name
            "#{klass_name}"
          end
          def self.meta_collection?
            #{meta}
          end
        RUBY

        if meta
          code << <<-RUBY.strip_heredoc
          expose :meta do
            expose :current_page, documentation: { type: Integer, desc: '当前页数' }
            expose :total_pages, documentation: { type: Integer, desc: '总页数' }
            expose :total_count, documentation: { type: Integer, desc: '总记录数' }
          end
          RUBY
        end

        code << <<-RUBY.strip_heredoc
          expose :data, documentation: { type: #{self}, is_array: true } do |instance, options|
            #{self}.represent instance, options
          end
        RUBY
        klass.instance_eval code
        self.const_set klass_name, klass
        klass
      end
    end
  end
end
