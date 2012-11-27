$(document).ready ->
  $("#song_key").change ->
    selected = $(@).children("option:selected").val()

    song_id = $(@).attr("data-sid")

    $.ajax("/songs/#{song_id}", {
       type: "PUT",
       dataType: "JSON",
       data: { song: { key: selected} }
     })

