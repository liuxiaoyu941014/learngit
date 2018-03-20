module AgentFrontendRoute
  def self.extended(router)
    router.instance_exec do
      scope path: '/agent-:agent', as: :agent_frontend do
        get 'index', to: 'agent#index'
        get 'market_page/:id', to: 'agent#market_page', as: :market_page
        get 'member_new', to: 'agent#member_new'
        post 'member_create', to: 'agent#member_create', as: :member_create
      end
    end
  end
end
