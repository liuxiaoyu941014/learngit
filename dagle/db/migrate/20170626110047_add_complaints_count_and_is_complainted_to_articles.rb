class AddComplaintsCountAndIsComplaintedToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :complaints_count, :integer, defalut: 0
    add_column :articles, :is_complainted, :boolean, index: true, defalut: false
  end
end
