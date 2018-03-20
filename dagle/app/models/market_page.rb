# == Schema Information
#
# Table name: market_pages
#
#  id                 :integer          not null, primary key
#  site_id            :integer
#  market_template_id :integer
#  name               :string
#  description        :string
#  features           :jsonb
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class MarketPage <  ApplicationRecord
  audited
  is_impressionable :counter_cache => true

  belongs_to :market_template
  belongs_to :site
  validates_presence_of :name, :site, :market_template
  has_many :image_item_relations, as: :relation
  has_many :image_items, :through => :image_item_relations
  has_many :sales_distribution_resources, class_name: 'SalesDistribution::Resource', as: 'object'
  #before_save :set_content_image

  def value_for(title, *opt)
    self.features[title] if self.features
  end

  def set_content_image
   return if content.blank?
   doc = Nokogiri::HTML(content)
   begin
     doc.search("img").each do |img|
       img.remove_attribute("style")
       if img.attributes["class"].nil?
         img.set_attribute("class", "img-responsive")
       elsif (val = img.attribute("class").value) !~ /img-responsive/
         img.set_attribute("class", "#{val} img-responsive")
       end
     end
   rescue => ex
     puts ex.message
   end
   self.content = doc.at("body").inner_html
 end

end
