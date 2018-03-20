class AddCommentsCountToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :comments_count, :integer, default: 0, index: true
  end
end
