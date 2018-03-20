## 多图片上传＋从图库中选择图片

### 1. 引入组件
    
    Vue.component ('ImageUpload', require('components/image_upload'))
    Vue.component ('ImageAlbum', require('components/image_album'))


### 2. view
- 在对应的表单中添加如下代码
 
 ```
    <image-album server="" selected-ids="" @delete="" @selected=""></image-select>
 ```

  ####参数说明：
  server: 图片上传的地址，必填项，例如: image_items_path
  
  name: 表单对应的参数名称，比如为产品添加图片，则name="product[image_item_ids][]"
  
  selected-list: 数组已选的图片id的集合

  #####组件接收消息
  delete: 图片删除后返回该图片id
  
  selected: 图片选中后返回该图片对象


### 3. controller

```
  # 获取Site或User的相册列表
  def index
    @image_items =
      if params[:site_id]
        @site = Site.find(@site)
        authorize @site, :edit # can edit site, then can get all images of site
        @site.image_items
      else # user's images
        current_user.image_items
      end
    if params[:tag]
      @image_items = @image_items.joins(:image_item_tags).where(image_item_tags: {name: params[:tag]})
    end
    if params[:ids]
      @image_items = @image_items.where(id: params[:ids].split(/[,]/))
    end
    @image_item_tags = @image_items.joins(:image_item_tags).select("image_item_tags.name").distinct.map(&:name)
    @image_items = @image_items.page(params[:page]).order(updated_at: :desc)
    render json: {image_items: ActiveModelSerializers::SerializableResource.new(@image_items, {}).as_json, tags: @image_item_tags}
  end

  def destroy
    @image_item = ImageItem.find(params[:id])
    flag, @image_item = ImageItem::Destroy.(@image_item, user: current_user)
    if flag
      render json: {}
    else
      head 403
    end
  end

```

