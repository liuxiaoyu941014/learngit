## 横向展示目录组件
### 1. 需要

  1. routes
  ```
  resources :catalogs
  ```
  2. gem
  ```
  gem 'closure_tree'
  ```
  3. create catalog_table

### 2. 引入组件

    <!-- 在 webpack/appliction

    ```
    Vue.component ('catalogList', require('components/catalog'))
    ``` -->

js 文件中:


```
new Vue({el: 'catalog-list'});
```

### 3. veiw
- 包含 C U R D
  ```
  // data-url :传入index url 必须传入
  <catalog-list data-url=admin_catalogs_path></catalog-list>
  ```

- 是否可以编辑，创建，删除
  ```
  editable='false' // type: Boolean, default: true 默认true为可以编辑
  ```
- 组件是否显示
  ```
  // 使用定义 catalogPanelShow(或者其他名称) 控制组件是否显示，并处理组件穿出来的关闭消息
  v-if='catalogPanelShow' // type: Boolean, default: true ，此处不要使用 v-show
  @closed="catalogPanelShow=false" // 接收组件中close消息

  ```
- 组件内部将返回选择的目录数组
  ```
  :default = "[]" // 传入默认选中值, 选中id

  <!-- 选中值由确认按钮触发返回值，所以需要设置下面两个属性 -->
  :show-confirm-buttons = "true" // type: Boolean 默认不显示底部确认按钮
  @selected = "ReceivingMethod" // 接收选中值数组 selected(){}: return array
  ```

### 4. controller

```
  def index
    respond_to do |format|
      format.html
      format.json do
        @catalogs = Catalog.roots
        render json: @catalogs
      end
    end
  end

  # POST /admin/catalogs
  def create
    authorize Catalog
    flag, @admin_catalog = Catalog::Create.(admin_catalog_params)
    if flag
      render json: @admin_catalog
    else
      json_update_failed!
    end
  end

  # PATCH/PUT /admin/catalogs/1
  def update
    authorize @admin_catalog
    flag, @admin_catalog = Catalog::Update.(@admin_catalog, admin_catalog_params)
    if flag
      head :ok
    else
      json_update_failed!
    end
  end

  # DELETE /admin/catalogs/1
  def destroy
    authorize @admin_catalog
    Catalog::Destroy.(@admin_catalog)
    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_catalog
      @admin_catalog = Catalog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_catalog_params
      params.permit(:parent_id, :name, :position)
    end
```

### 5. 序列化返回json

  create: serializers/catalog_serializer

  ```
  attributes :id, :name, :children
  has_many :children

  def children
    object.children.map{|c| CatalogSerializer.new(c).as_json }
  end
  ```

### 6. models

  ```
  has_closure_tree dependent: :destroy #关联删除下级目录
  belongs_to :parent
  ```
