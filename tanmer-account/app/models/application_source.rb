class ApplicationSource < ApplicationRecord
  belongs_to :application, class_name: 'Doorkeeper::Application'
  validates_presence_of :source
  validates_uniqueness_of :source, scope: :application_id

  def self.allow_cors?(app_id, source)
    app = Doorkeeper::Application.find_by(uid: app_id)
    app && app.sources.exists?(source: source)
  end
end
