update_tracks = ->
  window.tracks = []

  for i in [0...14]
    current_track_notes = []
    $(".cell[data-num=#{i}]").each (index, element) ->
      if element.getAttribute("data-active") == "true"
        Array.prototype.push.apply(current_track_notes, MidiEvent.createNote(window.keys[current_key][i]))
      else
        Array.prototype.push.apply(current_track_notes, MidiEvent.createNote("rest"))

    window.tracks.push(new MidiTrack({ events: current_track_notes }))


$(document).ready ->
  window.keys = {
    "AM": ["E3", "F#3", "G#3", "A3", "B3", "C#4", "D4", "E4", "F#4", "G#4", "A4", "B4", "C#5", "D5"],
    "Am": ["E3", "F3", "G3", "A3", "B3", "C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5", "D5"],
    "Ah": ["E3", "F3", "G#3", "A3", "B3", "C4", "D4", "E4", "F4", "G#4", "A4", "B4", "C5", "D5"],
    "BM": ["F#3", "G#3", "A#3", "B3", "C#4", "D#4", "E4", "F#4", "G#4", "A#4", "B4", "C#5", "D#5", "E5"],
    "Bm": ["F#3", "G3", "A3", "B3", "C#4", "D4", "E4", "F#4", "G4", "A4", "B4", "C#5", "D5", "E5"],
    "CM": ["G3", "A3", "B3", "C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5", "D5", "E5", "F5"],
    "Cm": ["G3", "Ab3", "Bb3", "C4", "D4", "Eb4", "F4", "G4", "Ab4", "Bb4", "C5", "D5", "Eb5", "F5"],
    "DM": ["A3", "B3", "C#4", "D4", "E4", "F#4", "G4", "A4", "B4", "C#5", "D5", "E5", "F#5", "G5"],
    "Dm": ["A3", "Bb3", "C4", "D4", "E4", "F4", "G4", "A4", "Bb4", "C5", "D5", "E5", "F5", "G5"],
    "EM": ["B3", "C#4", "D#4", "E4", "F#4", "G#4", "A4", "B4", "C#5", "D#5", "E5", "F#5", "G#5", "A5"],
    "Em": ["B3", "C4", "D4", "E4", "F#4", "G4", "A4", "B4", "C5", "D5", "E5", "F#5", "G5", "A5"],
    "FM": ["C4", "D4", "E4", "F4", "G4", "A4", "Bb4", "C5", "D5", "E5", "F5", "G5", "A5", "Bb5"],

    "Fm": ["C4", "Db4", "Eb4", "F4", "G4", "Ab4", "Bb4", "C5", "Db5", "Eb5", "F5", "G5", "Ab5", "Bb5"],
    "GM": ["D3", "E3", "F#3", "G3", "A3", "B3", "C4", "D4", "E4", "F#4", "G4", "A4", "B4", "C5"]
    "Gm": ["D3", "Eb3", "F3", "G3", "A3", "Bb3", "C4", "D4", "Eb4", "F4", "G4", "A4", "Bb4", "C5"]

  }

  window.current_key = $("#song_key").children("option:selected").val()

  update_tracks()
    

update_notes = ->
  for i in [0...window.keys[current_key].length]
    $(".key-note[data-keynum=#{i}]").hide().text("#{window.keys[window.current_key][i]}").fadeIn(200)


$(document).ready ->
  $("#song_key").change ->
    selected = $(@).children("option:selected").val()

    song_id = $(@).attr("data-sid")

    $.ajax("/songs/#{song_id}", {
       type: "PUT",
       dataType: "JSON",
       data: { song: { key: selected} }
    })

    window.current_key = selected

    update_notes()

$(document).ready ->
  update_notes()

$(document).ready ->
  $("#step-btn").click (e) ->
    e.preventDefault()
    $(@).attr("disabled", "disabled")
    gens_per_step = $("#generations_per_step").children("option:selected").val()
    $.ajax("/songs/#{$(@).attr("data-sid")}/step", {
      type: "GET"
      dataType: "script"
      data: { generations_per_step: gens_per_step }
    })

$(document).ready ->
  $("#play-btn").click (e) ->
    e.preventDefault()
    $(@).attr("disabled", "disabled")
    setTimeout ->
      $("#play-btn").removeAttr("disabled")
    , 1000
    update_tracks()
    window.song = MidiWriter({ tracks: window.tracks })
    window.song.play()

$(document).ready ->
  $("#save-btn").click (e) ->
    e.preventDefault()
    update_tracks()
    window.song = MidiWriter({ tracks: window.tracks })
    window.song.save()

$(document).ready ->
  $("#download-btn").click (e) ->
    e.preventDefault()
    window.song = MidiWriter({ tracks: window.tracks })
    window.song.save()
