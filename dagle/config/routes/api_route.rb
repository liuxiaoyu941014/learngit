require 'api_subdomain'
module ApiRoute
  def self.extended(router)
    router.instance_exec do
      # Grape API
      constraints ApiSubdomain do
        mount AppAPI::Root => '/'
        # if Rails.env.development?
          mount GrapeSwaggerRails::Engine => '/tm-docs'
        # else
          # root to: redirect('/not_found')
        # end
      end
      namespace :api do
        get '/', to: "home#index"     
        namespace :v1 do
          namespace :sessions do
            resource :sms, only: [:create]
          end
          resources :sessions, only: [:create]
          resources :materials, only: [:index, :create, :update, :show] do
            collection do
              post :batch_create
              get  :get_csv
            end
            member do
              get :audit
              get :purchase
            end
          end
          resources :orders, only: [:index, :create, :show, :update] do
            commentable
            resources :get_bat_file, only: [:index]
            member do
              put 'update_code'
              get :set_resource_url
            end
          end
          resources :logistics, only: [] do
            member do
              get :change_status
            end
          end
          resources :order_deliveries, only: [:create, :index]
          resources :material_management_details, only: [:index, :create]
          resources :material_managements, only: [:create]
          resources :material_warehouses, only: [:index, :create]
          resources :material_warehouse_items, only: [:index]
          resources :material_stock_alerts, only: [:index]
          resources :material_catalogs, only: [:index]
          resources :produces do
            resources :tasks, only: [:create, :index, :update]
            collection do
              get :need_export
            end
          end
          resources :tasks, only: [:index]
          resources :task_types, only: [:index]
          resources :deliveries, only: [:index, :create]
          resources :image_items, only: [:create]
          resources :sites, only: [:index]
          resources :members, only: [:index, :create]
          resources :search, only: [:index]
          resources :users, only: [:index]
          resources :vendors, only: [:index, :create, :destroy, :show, :update]
          resources :material_purchases, only: [:index, :create, :update, :show, :destroy] do
            member do
              get :audit
              post :update_material
            end
          end
          resources :material_purchase_details, only: [:update, :destroy]
          resources :attachments, only: [:create]
          resources :order_materials do
            collection do
              get :need_purchase
            end
          end
          resources :preorder_conversitions do
            commentable
            member do
              get :attachments_index
            end
          end
          resources :order_cvs, only: [:index, :create]
          resources :audits, only: [:index]

          resources :shops, only: [:index]
          resources :finance_histories, only: [:index, :create]
        end
      end
    end
  end
end
