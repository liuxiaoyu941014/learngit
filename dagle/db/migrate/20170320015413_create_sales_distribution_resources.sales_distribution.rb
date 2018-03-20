# This migration comes from sales_distribution (originally 20170318120216)
class CreateSalesDistributionResources < ActiveRecord::Migration[5.0]
  def change
    create_table :sales_distribution_resources do |t|
      t.string :type_name
      t.string :url, limit: 255
      t.references :user, index: { name: 'idx__sdr_user' }
      t.references :object, polymorphic: true, index: { name: 'idx__sdr_object' }
      t.string :code, unique: { name: 'idx__sdr_code' }
      t.jsonb :extra

      t.timestamps
    end
  end
end
