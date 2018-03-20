module CmsBackendRoute
  def self.extended(router)
    router.instance_exec do
      #admin backend
      namespace :admin do
        namespace :cms do
          if Settings.project.wgtong?
            resources :comments
          end
          resources :sites do
            resources :comments
            resources :keystores
            resources :channels do
              resources :pages
            end
            resources :pages
          end
        end
      end
      #agent backend
      namespace :cms do
        resources :sites do
          resources :comments
          resources :keystores
          resources :channels do
            resources :pages
          end
          resources :pages
        end
      end
    end
  end
end
