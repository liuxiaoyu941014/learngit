module AppAPI::Actions
  extend ActiveSupport::Concern
  included do
    before do
      def remote_ip
        request.env['REMOTE_ADDR']
      end
      def request_uuid
        @request_uuid ||= SecureRandom.uuid
      end
      audit = Audited::Sweeper.new
      audit.controller = self
      Audited::Sweeper::STORED_DATA.each { |k,m| Audited.store[k] = send(m) }
    end
    after do
      Audited::Sweeper::STORED_DATA.keys.each { |k| Audited.store.delete(k) }
    end
  end
end
