$(document).ready ->
  $(document).delegate ".rcell", "click", (e) ->
    e.preventDefault()

    editable = $(@).attr("data-editable")
    return false if editable == "false"

    rule_id = $(@).data("rid")
    song_id = $(@).attr("data-sid")

    $(@).fadeOut 100, ->
      $(@).toggleClass("rcell_active").fadeIn(200)

    active = $(@).attr("data-active")
    if active == "true"
      $(@).attr("data-active", "false")
    else
      $(@).attr("data-active", "true")

    to_match_str = ""
    $("#rule_#{rule_id} .rcell").each (index, element) ->
      active = element.getAttribute("data-active")
      if active == "true"
        to_match_str += "1"
      else
        to_match_str += "0"
      
    $.ajax("/songs/#{song_id}/rules/#{rule_id}", {
      type: "PUT",
      dataType: "JSON",
      data: { rule: { to_match: to_match_str} }
    })

$(document).ready ->
  $(document).delegate ".rnewcell", "click", (e) ->
    e.preventDefault()

    rule_id = $(@).data("rid")
    song_id = $(@).attr("data-sid")

    $(@).fadeOut 100, ->
      $(@).toggleClass("rnewcell_active").fadeIn(200)

    active = $(@).attr("data-active")
    new_cell_str = ""
    if active == "true"
      $(@).attr("data-active", "false")
      new_cell_str = "0"
    else
      $(@).attr("data-active", "true")
      new_cell_str = "1"

    $.ajax("/songs/#{song_id}/rules/#{rule_id}", {
      type: "PUT",
      dataType: "JSON",
      data: { rule: { new_cell: new_cell_str} }
    })

$(document).ready ->
  $("#new-rule-btn").click (e) ->
    e.preventDefault()
    $(@).attr("disabled", "disabled")
    $.ajax("/songs/#{$(@).attr("data-sid")}/rules", {
      type: "POST",
      dataType: "script",
      data: { rule: { to_match: "000", new_cell: "0" } }
    })

$(document).ready ->
  $(document).delegate ".delete-rule-btn", "click", (e) ->
    e.preventDefault()
    $.ajax("/songs/#{$(@).attr("data-sid")}/rules/#{$(@).attr("data-rid")}", {
      type: "DELETE",
      dataType: "script"
    })

$(document).ready ->
  $(document).delegate "select[id^=neighborhood_size_]", "change", (e) ->
    new_size = $(@).children("option:selected").val()
    $.ajax("/songs/#{$(@).attr("data-sid")}/rules/#{$(@).attr("data-rid")}", {
      type: "PUT",
      dataType: "script",
      data: { rule: { neighborhood_size: new_size } }
    })
