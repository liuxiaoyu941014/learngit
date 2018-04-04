module Doorkeeper
  module TanmerApplicationConcern
    extend ActiveSupport::Concern
    included do
      MAIN_ID = 1
      has_many :sources, class_name: 'ApplicationSource', dependent: :destroy
      has_many :permissions, dependent: :destroy, foreign_key: :app_id
      attr_accessor :source_urls
      after_initialize :init
      before_destroy :check_can_destroy?
      before_commit :save_sources_from_source_urls, on: [:create, :update]
      def self.main
        find_by(id: MAIN_ID)
      end
    end

    private

    def init
      self.source_urls = self.sources.map(&:source).join(';')
    end

    def save_sources_from_source_urls
      urls = self.source_urls.to_s.split(/\s*;\s*/).select { |url| url =~ %r{^https?://[a-z0-9]}i }.uniq
      if urls.empty?
        self.sources.destroy_all
      else
        self.sources.where.not(source: urls).destroy_all
        new_urls = urls - self.sources.map(&:source)
        self.sources.create(new_urls.map{ |u| {source: u } }) if new_urls.any?
      end
    end

    def check_can_destroy?
      if id == MAIN_ID
        errors.add :base, "不能删除"
        throw :abort
      end
    end

    def generate_uid
      self.uid = Doorkeeper::OAuth::Helpers::UniqueToken.generate(size: 6) if uid.blank?
    end

    def generate_secret
      self.secret = Doorkeeper::OAuth::Helpers::UniqueToken.generate(size: 12) if secret.blank?
    end
  end
end
