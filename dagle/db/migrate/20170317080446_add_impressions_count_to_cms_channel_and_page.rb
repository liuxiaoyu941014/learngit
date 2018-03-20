#添加访问量统计到model
class AddImpressionsCountToCmsChannelAndPage < ActiveRecord::Migration[5.0]
  def change
    add_column :cms_channels, :impressions_count, :integer, default: 0
    add_column :cms_pages, :impressions_count, :integer, default: 0
  end
end
