$ ->

  focusOnTerm = -> $("input[name='search[parameters][term]']:visible").focus()
  $("li").bind "shown", focusOnTerm
  focusOnTerm()

  $("a.monitor-by-email.toggler").click ->
    anchor = $(this)
    newState = anchor.data("monitoring") != true
    anchor.data "monitoring", newState
    id = anchor.data("id")
    $.get "/searches/#{id}/monitor_by_email"
    img = if newState then "mail-active" else "mail-inactive"
    anchor.find("img").attr "src", "/assets/#{img}.png"
    $("div.alert-error").slideUp()
    $("a.monitor-by-email").popover("hide").popover("disable")
    return false

  $("a.delete-search").click ->
    anchor = $(this)
    row = anchor.closest("tr")
    id = row.data("id")
    $.get "/searches/#{id}/delete"
    row.fadeOut 500
    return false
