$(document).ready ->
  agentMembers =  $('.agent-members.index')
  if agentMembers.length > 0
    notice = agentMembers.find('.member-container').data('notice')
    if notice.length > 0
      $.gritter.add({title: '提示', text: notice})
  moreChoicesDom = $(".more-choices").clone()
  $(".search-panel-title .hide").append(moreChoicesDom)
  if $(".search-panel-title .hide").hasClass("open")
    $("#search_keywords").parent().removeClass("input-group")
    $(".keyword-search-btn").hide()
  else
    $(".search-panel-title form .more-choices").remove()
  $(".open-more").on 'click', ->
    if $("#search_keywords").parent().hasClass("input-group")
      $("#search_keywords").parent().removeClass("input-group")
      $(".search-panel-title form").append(moreChoicesDom)
      $(".keyword-search-btn").hide()
      $(".search-panel-title form .more-choices").hide().slideDown()
    else
      $("#search_keywords").parent().addClass("input-group")
      $(".keyword-search-btn").show()
      $(".search-panel-title form .more-choices").slideUp ->
        $(this).remove()
  $radios = $('input:radio')
  $radios.change ->
    $($(this).parent().parent().parent()).find('input:radio').parent().removeClass('checked')
    $(this).parent().addClass('checked')