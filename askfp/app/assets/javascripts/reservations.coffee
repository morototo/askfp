ready = ->
  replaceSelectOptions = ($select, results) ->
    $select.html $('<option>')
    $.each results, ->
      option = $('<option>').val(this[0]).text(this[0])
      $select.append(option)

  $('.date-picker').datepicker(
    format: 'yyyy-mm-dd',
    minDate: 0,
    autoClose: true,
    onSelect: (selected_date) ->
      fp_id = $('#reservation_fp_id').val()
      $selectChildren = $('#reservation_start_at')
      replaceSelectOptions($selectChildren, [])
      $.ajax
        type: 'GET'
        url: '/reservations/set_time'
        data: { select_date: selected_date, fp_id: fp_id}
        dataType: 'json'
        success: (times)->
          replaceSelectOptions($selectChildren, times)
      return
  );

  if $('#reservation_reservation_date').val()
    selected_date = $('#reservation_reservation_date').val()
    fp_id = $('#reservation_fp_id').val()
    $selectChildren = $('#reservation_start_at')
    $.ajax
      type: 'GET'
      url: '/reservations/set_time'
      data: { select_date: selected_date, fp_id: fp_id}
      dataType: 'json'
      success: (times)->
        replaceSelectOptions($selectChildren, times)
    return

$(document).ready(ready)
$(document).on('turbolinks:load', ready)