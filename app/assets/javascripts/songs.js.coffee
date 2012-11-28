$(document).ready ->
  $("#song_key").change ->
    selected = $(@).children("option:selected").val()

    song_id = $(@).attr("data-sid")

    $.ajax("/songs/#{song_id}", {
       type: "PUT",
       dataType: "JSON",
       data: { song: { key: selected} }
     })

$(document).ready ->
  $("#step-btn").click (e) ->
    e.preventDefault()
    $.ajax("/songs/#{$(@).attr("data-sid")}/step", {
      type: "GET"
      dataType: "script"
      data: { generations_per_step: $("#generations_per_step").val() }
    })
