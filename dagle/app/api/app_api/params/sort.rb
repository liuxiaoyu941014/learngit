module AppAPI::Params
  # API中可以附带排序参数
  class Sort
    attr_reader :value, :fields
    # fields is an Array indicate which fields are sortable
    # fields: 支持排序的字段，数组型，如：[:id, :name, :updated_at]
    # default: 默认排序方式，字符串型，如：'updated_at desc'
    # value: 获取到的排序参数，字符串型，如：'updated_at desc, name asc'
    def initialize(fields:, default:, value:)
      @fields = fields.map(&:to_s)
      @default = default
      @value = parse(value)
    end
    def parse(value)
      parsed_value = []
      value.to_s.split(',').each do |field_str|
        field, direction = field_str.split(' ')
        field.strip! if field
        direction.strip! if direction
        if fields.include?(field)
          parsed_value << "#{field} #{parse_direction(direction)}"
        end
      end
      @value = parsed_value.empty? ? default : parsed_value.join(', ')
    end
    def parse_direction(str)
      str.to_s.downcase.strip == 'desc' ? 'desc' : 'asc'
    end
  end
end
