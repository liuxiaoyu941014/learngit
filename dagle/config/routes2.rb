  #--------------------------------------------xj-------------
  #管理员
  namespace :admin do
    # [通用设置类]
    resources :keystore #通用变量存储器
    resources :logs #所有对Model CUD的操作都写进logs, 所有用户的Delete都为假删除，除非admin管理员执行。    

    # [标签管理] - acts-as-taggable-on
    # 后台可以对用户打的标签进行修改、合并、删除操作
    resources :tags do 
      member do
        post :add_test_data
      end
      collection do
        post :merge #合并相同的标签
      end
    end

    # [分类管理]
    # 多级分类CRUD
    resources :catalogs

    # [音乐管理]
    #待小陶确定API实现情况
    resources :net_ease_musics, only: [] do
      collection do
        post :search
      end
    end

    # [站点管理] 
    resources :sites do
      resource :site_setting #网站设置属性, has_one
    end
    resources :pages do
      resources :page_items do
        collection do
          post :sort #排序
        end
      end
      collection do
        post :sort #排序
      end
      resource :product do #扩展产品，has_one
        resources :product_variants #产品额外变量
      end
      resource :article #扩展文章，has_one
      #resource :event #扩展，has_one 二期考虑
      #resource :task #扩展，has_one 二期考虑
    end

    # [订单-支付]
    resources :orders do #order belongs_to :page (not product)
      resources :payments
    end

    # [会员管理] 
    resources :users do
      resource :member do #user has_one member
        resources :member_addresses #收货地址
      end
      resources :bills # [账单管理]
    end
  end