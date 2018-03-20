$(document).ready ->
  pages = $('body.cms-pages')
  if pages.length > 0
    # tags
    default_cms_site_tags = pages.find('.cms-page-tags').data('cms-site-tags')
    pages.find('.cms-page-tags').tagit({
      fieldName: "cms_page[tag_list][]",
      availableTags: default_cms_site_tags
    })
    pages.find(".most-tag-list span.label").on 'click', ->
      pages.find('.cms-page-tags').tagit 'createTag', $(this).text()
