class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.references :site, foreign_key: true
      t.references :user, foreign_key: true
      t.string :title
      t.string :content
      t.string :type
      t.jsonb :features

      t.timestamps
    end
  end
end
