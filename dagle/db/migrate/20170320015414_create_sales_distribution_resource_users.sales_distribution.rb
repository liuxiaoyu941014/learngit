# This migration comes from sales_distribution (originally 20170319081137)
class CreateSalesDistributionResourceUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :sales_distribution_resource_users do |t|
      t.references :resource, index: { name: 'idx__sdr_resource_user_resource'}
      t.references :user, index: { name: 'idx__sdr_resource_user_user'}
      t.string :ip
      t.string :user_agent

      t.timestamps
    end
  end
end
