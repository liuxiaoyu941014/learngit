$(document).ready ->
  bodyIndex = $('.agent-finance_bills.new')
  if bodyIndex.length > 0
    selectAllCheckbox = bodyIndex.find('#selectAll')
    selectAllCheckbox.change ->
      bodyIndex.find('.order-checkbox').each (index, ele) ->
        if selectAllCheckbox[0].checked
          ele.checked = true
        else
          ele.checked = false
        calculate_total_amount()
        return
    bodyIndex.find('.order-checkbox').change ->
      calculate_total_amount()
  calculate_total_amount = ->
    total = 0
    bodyIndex.find('.order-checkbox').each (index, ele) ->
      if ele.checked
        total += parseFloat($(ele).parents('.order-row').find('.order-price').text())
      if total > 0
        bodyIndex.find('.submit-form').css('display', 'block')
      else
        bodyIndex.find('.submit-form').css('display', 'none')
      bodyIndex.find('#total_amount').text(total.toFixed(2))