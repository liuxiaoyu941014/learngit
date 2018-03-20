class AddFeaturesToFinanceHistories < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_histories, :features, :jsonb
  end
end
