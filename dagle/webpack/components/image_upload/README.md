## 单个图片上传
### 1. 准备工作

  1. routes
  ```
  resources :image_items
  
  ```
  2. create table image_items

### 2. 引入组件
    
    Vue.component ('ImageUpload', require('components/image_upload'))


### 3. view
- 在对应的表单中添加如下代码
 
 ```
    <image-upload server="" name="" auto-upload="" v-model="" image-url=""></image-upload>
 ```

  ####参数说明：
  server: 图片上传的地址，必填项，例如: image_items_path
  
  name: 表单对应的参数名称，比如为产品添加图片，则name="product[image_item_ids][]"
  
  auto-upload: 布尔类型，图片是否自动上传
  
  v-model: 如果是修改图片，则传入图片的ID
  
  image-url: 如果是修改图片，传入图片url

### 4. controller

```
  def create
    data = image_item_params
    if params[:site_id]
      @site = Site.find(@site)
      authorize @site, :edit
    else
      authorize ImageItem
    end
    flag, @image_item =
      if data[:id]
        ImageItem::Update.(data[:id], data, user: current_user)
      else
        ImageItem::Create.(data, user: current_user)
      end
    if flag
      render json: @image_item.id
    else
      head 403
    end
    end
  
  private
  def image_item_params
    json_image_data = {}
    params.each_pair do |k, v|
      if v[:image_item_ids]
        hash_params = {}
        json_image_data = JSON.parse(v[:image_item_ids].first)
        hash_params[:name] = json_image_data["input"]["name"]
        hash_params[:data] = json_image_data["input"]["name"]
        hash_params[:image] = json_image_data['output']["image"]
        hash_params[:id] = json_image_data['server']
        # hash_params[:user_id] = current_user.id
        # hash_params[:site_id] = params[:site_id]
        hash_params[:owner] = current_user
        return hash_params
      end
    end
    {}
  end
```



### 5. models

  ```
  belongs_to :owner, polymorphic: true
validates_presence_of :owner, :data
  ```
