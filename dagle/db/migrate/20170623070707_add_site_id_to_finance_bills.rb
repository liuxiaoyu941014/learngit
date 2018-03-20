class AddSiteIdToFinanceBills < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_bills, :site_id, :integer
  end
end
