class ApplicationRecord < ActiveRecord::Base
  include CastPinyinConcern
  include QueryAsCSVConcern
  self.abstract_class = true
end
