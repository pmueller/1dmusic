$(document).ready ->
  window.keys = { "CM": ["A3", "B3", "C4", "D4", "E4", "F4", "G4", "A5", "B5", "C5", "D5", "E5"],
  "Cm": [ "Ab4", "Bb4", "C4", "D4", "Eb4", "F4", "G4", "Ab5", "Bb5", "C5", "D5", "Eb5"] }

  window.tracks = []

  current_key = $("#song_key").children("option:selected").val()

  for i in [1...12]
    current_track_notes = []
    $(".cell[data-num=#{i}]").each (index, element) ->
      if element.getAttribute("data-active") == "true"
        Array.prototype.push.apply(current_track_notes, MidiEvent.createNote(window.keys[current_key][i]))
      else
        Array.prototype.push.apply(current_track_notes, MidiEvent.createNote("C0"))

    window.tracks.push(new MidiTrack({ events: current_track_notes }))
  

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

$(document).ready ->
  $("#play-btn").click (e) ->
    e.preventDefault()
    noteEvents = []
    ["C4", "E4", "G4"].forEach (note) ->
      Array.prototype.push.apply(noteEvents, MidiEvent.createNote(note))
    track = new MidiTrack({ events: noteEvents })
    track2 = new MidiTrack({ events: noteEvents.reverse() })
    window.song = MidiWriter({ tracks: window.tracks })
    window.song.play()

$(document).ready ->
  $("#download-btn").click (e) ->
    e.preventDefault()
    window.song = MidiWriter({ tracks: window.tracks })
    window.song.save()
