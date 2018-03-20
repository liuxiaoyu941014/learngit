class AddSourceToArtiles < ActiveRecord::Migration[5.0]
  def change
    add_reference :articles, :source, polymorphic: true
  end
end
