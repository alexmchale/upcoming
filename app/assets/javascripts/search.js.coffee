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

  $("a.js-acknowledge-result").click ->
    anchor = $(this)
    row = anchor.closest("tr")
    id = row.data("id")
    $.get "/search_results/#{id}/acknowledge", ->
      row.fadeOut 500
      count = parseInt($("#search-results-link").data("result-count"), 10)
      count -= 1
      count = 0 if count < 0
      label = if count == 1 then "1 New Match" else "#{count} New Matches"
      $("#search-results-link").data("result-count", count).html(label)
      if count == 0
        $("#search-results-navbar").hide
        window.location = "/searches"
    return false
