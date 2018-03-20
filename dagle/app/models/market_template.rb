# == Schema Information
#
# Table name: market_templates
#
#  id          :integer          not null, primary key
#  catalog_id  :integer          not null
#  base_path   :string           not null
#  name        :string           not null
#  keywords    :string
#  description :string
#  image_path  :string
#  html_source :text
#  form_source :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  features    :jsonb
#

class MarketTemplate < ApplicationRecord
  audited
  validates_presence_of :name, :base_path, :html_source
  belongs_to :catalog
  has_many :image_item_relations, as: :relation
  has_many :image_items, :through => :image_item_relations

  before_save :generate_form

  private
  def generate_form
    #  <%= @market_page.value_for('title', title: '标题', typo: 'string', default: 'awef', required: true) %>
    #  a =  "{typo: 'string', default: true, required: true}"
    #  > eval a
    # => {:typo=>"string", :default=>true, :required=>true}
    form_html = {}
    #reg1 = /@market_page.value_for\(\s*'([^'']+)'(?:,\s*(.*))?\)/
    reg2 = /@market_page.value_for\(\s*['"]([^''""]+)['"](?:,\s*(.*))?\)/
    self.html_source.scan(reg2).each do |match|
      next if form_html.include?(match[0])
      #parse a string into hash
      opt = {}
      opt = eval('{' + match[1] + '}') if match[1]
      form_html[match[0]] = get_input(match[0], opt)
    end
    self.form_source = form_html.values.join
  end

  # 参数：
  # typo: string, text, dialog
  # title: '标题'
  # placeholder: '占位说明'
  # default: '默认值'
  # options: ['a', 'b', 'c']
  #
  #<%= @market_page.value_for('ipt', title: '选项', typo: 'select', default: '活动开始了！', options: ["A类", "B类", "C类"])
  #<%= @market_page.value_for('title', typo: 'string', default: true, required: true) %>
  #<%= @market_page.value_for('weding_date', typo: 'date', title: '婚礼日期', required: true)  %>
  def get_input(name, opt)
    opt[:typo] = opt[:type] if opt[:typo].blank? #alias
    opt[:typo] = 'string' if opt[:typo].blank? #default
    opt[:title] = name if opt[:title].blank? #init title

    arr = [%{<!-- #{name}-->}]
    arr << %{\n<div class="control-group form-group">}
    arr << %{\n   <label class="}
    arr << 'required ' if opt[:required] == true
    arr << opt[:typo]
    arr << %{ control-label">}
    arr << %{<abbr title="必填项">*</abbr>} if opt[:required] == true
    arr << opt[:title]

    arr << %{</label>}
    arr << %{\n    <div class="controls">\n        }
    case opt[:typo].downcase
    when 'string', 'dialog'
      arr << %{<input class="form-control #{opt[:typo]} #{if opt[:required] then 'required' end}" id="market_page_#{name}" name="mpage[#{name}]" typo="#{opt[:typo]}"}
      arr << %{ placeholder="#{opt[:placeholder]}"}
      arr << %{ value="<%= @market_page.value_for('#{name}') || '#{opt[:default]}' %>">}
    when 'int', 'integer', 'numeric'
      arr << %{<input class="form-control numeric integer #{if opt[:required] then 'required' end}" id="market_page_#{name}" name="mpage[#{name}]" step="1" type="number"}
      arr << %{ value="<%= value_for(@market_page, '#{name}') || '#{opt[:default]}' %>">}
    when 'text', 'textarea'
      arr << %{<textarea class="form-control text" id="market_page_#{name}" name="mpage[#{name}]">}
      arr << %{<%= @market_page.value_for('#{name}') || '#{opt[:default]}' %>}
      arr << %{</textarea>}
    when 'select', 'radio'
      arr << %{<select id="market_page_#{name}" name="mpage[#{name}]" class="form-control input-xlarge">}
      opt[:options].each do |option|
        arr << %{<option value="#{option}">#{option}</option>}
      end
      arr << %{</select>}
    else
      raise "bad input typo: #{opt[:typo]}"
    end
    arr << %{\n    </div>}
    arr << %{\n</div>\n\n}
    arr.join
  end

end
