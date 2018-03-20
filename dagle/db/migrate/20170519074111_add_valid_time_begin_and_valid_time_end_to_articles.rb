class AddValidTimeBeginAndValidTimeEndToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :valid_time_begin, :date, index: true
    add_column :articles, :valid_time_end, :date, index: true
  end
end
