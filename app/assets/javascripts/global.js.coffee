$ ->

#  # Switch what navbar entry is active when a pjax link is clicked in it.
#  $("ul.nav a[data-pjax]").click ->
#    $("ul.nav li").removeClass "active"
#    $(this).closest("li").addClass "active"
#    return true
#
#  # Activate PJAX.
#  $("a[data-pjax]").pjax
#    timeout: 5000
