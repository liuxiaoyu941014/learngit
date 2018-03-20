module AppAPI
  module Helpers
    # 通过Header的Authorization获取当前用户
    def current_user
      if @current_user.nil?
        token_str = headers['Authorization']
        return @current_user=false if token_str.blank?
        token_str = token_str.sub(/^Bearer /, '')
        api_token = ApiToken.find_by(token: token_str)
        return @current_user=false if api_token.nil? || api_token.expired?
        @current_user = api_token.user
      end
      @current_user
    end

    def error!(msg, *args)
      if msg.is_a?(ActiveModel::Errors)
        super({ error: msg.as_json, error_message: msg.full_messages.join(', ') }, *args)
      elsif msg.is_a?(String)
        super({ error: msg, error_message: msg }, *args)
      else
        super
      end
    end

    # 验证用户
    def authenticate!
      error!({ error: '身份验证失败' }, 401) unless current_user
    end

    # 检查用户是否拥有权限
    def permission?(*symbol_names, any: false)
      current_user && current_user.permission?(*symbol_names, any: any)
    end

    # 检查用户权限，无权限就报错
    def permission!(*symbol_names, any: false)
      permission?(*symbol_names, any: any) || error!({ error: '没有权限' }, 403)
    end

    # 分页数据
    def paginate_collection(collection, params)
      collection.page(params[:_page]).per(params[:_per_page])
    end

    # 生产分页数据的JSON
    def wrap_collection(collection, with_entity, options={})
      present meta: {
        current_page: collection.current_page,
        total_pages: collection.total_pages,
        total_count: collection.total_count
      }
      present :data, collection, options.merge(with: with_entity)
    end

    # 用_sortable中的参数对集合排序
    def sort_collection(collection)
      params[:_sort] ? collection.order(params[:_sort].value) : collection
    end
  end
end
