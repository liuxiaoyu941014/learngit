require 'csv'
module QueryAsCSVConcern
  extend ActiveSupport::Concern
  included do
    scope :as_csv, ->(options = {}) do
      options = options.symbolize_keys
      columns =
        if options.include?(:only)
          Array(options[:only])
        elsif options.include?(:except)
          attribute_names - Array(options[:except]).map(&:to_s)
        else
          attribute_names
        end
      CSV.generate do |csv|
        csv << columns
        all.each do |record|
          # some columns are stored_accessor, so can't query from DB directly
          csv << columns.map{ |col| record.send(col) }
        end
      end
    end
  end
end
