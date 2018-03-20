require 'doc_subdomain'
module DocRoute
  def self.extended(router)
    router.instance_exec do
      constraints(DocSubdomain) do
        root :to => "docs#index"
        get "/(:page)", to: 'docs#index', as: :doc, constraints: { page: /.+\.md/ }
      end
    end
  end
end
