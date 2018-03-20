class ChangeIsProcessForForageTables < ActiveRecord::Migration[5.0]
  def change
    change_column :forage_run_keys, :is_processed, :string, default: 'n', index: true
    change_column :forage_simples, :is_processed, :string, default: 'n', index: true
    add_column :forage_details, :is_merged, :string, default: 'n', index: true
  end
end
