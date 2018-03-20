module CastPinyinConcern
  extend ActiveSupport::Concern
  require 'chinese_pinyin'
  class_methods do

    def cast_pinyin_for(*attrs)
      @@pinyin_mappings = {}
      mattr_reader :pinyin_mappings

      attrs.each do |attr|
        if attr.is_a?(Hash)
          pinyin_mappings.update(attr.symbolize_keys)
        else
          pinyin_mappings[attr.intern] = "#{attr}_py"
        end
      end

      before_validation -> do
        self.class.pinyin_mappings.each_pair do |title, title_py|
          v = self.send(title).present? ? Pinyin.t(self.send(title)){ |letters| letters[0].upcase }.gsub(/ /, '') : nil
          self.send("#{title_py}=", v)
        end
      end
    end
  end
end
