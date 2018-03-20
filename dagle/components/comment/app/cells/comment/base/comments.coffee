$(document).ready ->
  processCommentBlock = ()->
    blockEle  = $(this)
    url       = blockEle.data('url')
    imagePath = blockEle.data('image')
    filePath  = blockEle.data('file')
    currentUserId = blockEle.data('current')
    blockEle.attr 'uuid', "#{new Date().getTime()}-#{Math.random()}"

    postComment = (target) ->
      if target == 'comment'
        this.replyTo = null
        content_info = this.content
      else if target == 'reply'
        content_info = this.replyContent
      self = this
      self.posting = true
      images = []
      $(".comment #images-content input[name='order[image_item_ids][]']").each( ->
        images.push $(this).val()
      )
      dataAll =
        'comment[content]': content_info
        'comment[parent_id]': (this.replyTo and this.replyTo.id)
        'comment[attachment_ids]': self.features.files.map((f) ->
            return f.id
          )
        'comment[image_item_ids]': images
        'comment[offer]': self.features.offer
      $.post
        url: url
        beforeSend: (xhr)->
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        data: dataAll
        success: (data)->
          self.posting = false
          self.replying = false
          self.comments.unshift data.comments
          self.content = ''
          self.features =
            files: []
            images: []
            offer: ''
        error: (error)->
          self.posting = false
          alert error

    loadComments = ->
      $(window).scrollTop(0)
      app._data.currentUserId = currentUserId
      $.get url, 'page': app._data.currentPage
      .success (data)->
        app._data.loading = false
        app._data.comments = data.comments
        app._data.pageCount = data.total_pages
        app._data.currentPage = data.current_page
      .error (error)->
        app._data.error = true

    replyModel = (comment_target)->
      this.replyTo = comment_target
      this.replying = true
    upFile = (formdata, index) ->
      $.ajax
        url: filePath
        type: 'post'
        data: formdata
        cache: false
        processData: false
        contentType: false
        success: (data)->
          if data.status == 'ok'
            app._data.features.files[index].id = data.attachment.id
            app._data.features.files[index].name = data.attachment.attachment_file_name
            app._data.features.files[index].url = data.attachment.attachment_url
            app._data.features.files[index].upStatus = 2
          else
            alert '文件上传失败'
            app._data.comment.files[index].upStatus = 1
        error: (data)->
          console.log data
          alert '文件上传失败'

    app = new Vue
      el: "[rel='comment-block'][uuid='#{blockEle.attr('uuid')}']"
      data:
        comments: []
        showFullImage: false
        imageRrc: ''
        error: false
        posting: false
        loading: true
        replying: false
        replyTo: null
        content: ''
        replyContent: ''
        pageCount: null
        currentPage: null
        currentUserId: ''
        features:
          files: []
          images: []
          offer: ''
      methods:
        postComment: postComment
        replyModel: replyModel
        loadComments: loadComments
        onShowImage: (src)->
          this.imageRrc = src
          this.showFullImage = true
        removeFile: (file, index)->
          self = this
          $.ajax
            url: filePath+'/'+file.id
            type: 'delete'
            success: (data)->
              if data.status == 'ok'
                self.features.files.splice(index, 1)
              else
                alert('删除文件失败')
            error: (data)->
              console.log data
              alert('删除文件失败')
        onChangeFile: (e)->
          self = this
          return alert '浏览器不支持此插件' unless window.FormData
          files = e.target.files
          formdata = new FormData()
          # each up file
          for file in files
            formdata.append 'file', file
            thisFile =
              id: ''
              name: file.name
              url: ''
              upStatus: 0
            self.features.files.push(thisFile)
            index = self.features.files.indexOf(thisFile)
            upFile(formdata, index)
        onChangeImage: (e)->
          self = this
          return alert '浏览器不支持此插件' unless window.FormData
          # $.ajax
          #   url: imagePath
          #   type: 'post'
          #   cache: false
          #   processData: false
          #   contentType: false
          #   data: new FormData($("#upImages")[0])
          #   dataType: 'json'
          #   success: (data)->
          #     self.files = data
          #   error: (data)->
          #     console.log data
          #     alert '图片上传失败'
        onTestImage: (typeStr)->
          if typeStr.indexOf('image') > -1
            return true
          else
            return false
        formatDate: (str)->
          timeDate = new Date(str)
          year = timeDate.getFullYear()
          month = timeDate.getMonth() + 1
          date = timeDate.getDate()
          hour = timeDate.getHours()
          minute = timeDate.getMinutes()
          second = timeDate.getSeconds()
          return year + '-' + month + '-' + date + '/' + hour + ':' + minute + ':' + second
    loadComments()


  # apply to all comment-block
  $('[rel="comment-block"]').each processCommentBlock
