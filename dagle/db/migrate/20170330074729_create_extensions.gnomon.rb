# This migration comes from gnomon (originally 20170328013626)
class CreateExtensions < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE EXTENSION IF NOT EXISTS cube"
    execute "CREATE EXTENSION IF NOT EXISTS earthdistance"
  end
end
