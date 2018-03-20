class AddPaidAtToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :paid_at, :datetime
  end
end
