class Forage::RunKey < ApplicationRecord
  audited
  belongs_to :source, class_name: '::Forage::Source'
  has_many :simples, dependent: :destroy
  validates_uniqueness_of :source_id, scope: :date
end
