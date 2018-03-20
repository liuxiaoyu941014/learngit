class RebuildTreeForSites < ActiveRecord::Migration[5.0]
  def up
    Site.rebuild!
  end

  def down
  end
end
