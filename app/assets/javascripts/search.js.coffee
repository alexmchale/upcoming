$ ->

  $("li").bind "shown", ->
    $("input[name='search[term]']:visible").focus()
