module AppAPI::SharedParams
  extend Grape::API::Helpers

  # 分页参数
  params :pagination do |options|
    max_per_page = options[:max_per_page] || 50
    optional :_page, type: Integer, default: 1, desc: '需要显示的页码'
    optional :_per_page,
             type: Integer,
             values: { value: 1..max_per_page, message: "不能超过#{max_per_page}" },
             default: 10,
             desc: "每页显示数量, 默认10, 最大不能超过#{max_per_page}"
  end

  # 排序参数
  params :sort do |options|
    fail "missing :fields" unless options.include?(:fields)
    optional :_sort,
             type: AppAPI::Params::Sort,
             coerce_with: ->(c) { AppAPI::Params::Sort.new(fields: options[:fields], default: options[:default], value: c) },
             desc: "支持排序的字段：#{options[:fields].join(', ')}"
  end
end
