## 分享
### 依赖引入:
  - jqery
  - bootstrap
  - clipboard.js
  - modal组件
### 1.传入参数:
  - **title:**       String  标题
  - **url:**         String  分享链接地址
  - **qrImageUrl:**  String  二维码图片地址(使用此图片地址,将不在组件内生成二维码)
  - **showModal:**   Boolean 控制显示
### 2.使用
  ```
  <share-modal title="title" :url="url" :show-modal="showSharModal" @close="showSharModal = false"></share-modal>
  ```
