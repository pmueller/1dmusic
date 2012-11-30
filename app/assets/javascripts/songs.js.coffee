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
  $("#mapping").change ->
    selected = $(@).children("option:selected").val()

    if selected == "pitch" || selected == "sum"
      $(".key-note").hide()
      $(".key-info").hide()

    if selected == "note"
      $(".key-note").show()
      $(".key-info").show()

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

    mapping_type = $("#mapping").children("option:selected").val()

    if mapping_type == "note"
      update_tracks()
      window.song = MidiWriter({ tracks: window.tracks })
      window.song.play()
    
    if mapping_type == "pitch"
      n_events = []
      $(".generation").each  ->
        gen_str = ""
        cells = $(@).children(".cell")
        cells.each (index, element) ->
          active = element.getAttribute("data-active")
          if active == "true"
            gen_str += "1"
          else
            gen_str += "0"
        gen_in_bin = parseInt(gen_str, 2)
        pitch = (gen_in_bin % 127 ) + 1
        duration = gen_in_bin % 64

        Array.prototype.push.apply(n_events, MidiEvent.createNote({ pitch: pitch }))

      t = new MidiTrack({ events: n_events })
      s = MidiWriter({ tracks: [t] })
      s.play()

    if mapping_type == "sum"
      n_events = []
      bin_total = 0
      $(".generation").each  ->
        gen_str = ""
        cells = $(@).children(".cell")
        cells.each (index, element) ->
          active = element.getAttribute("data-active")
          if active == "true"
            gen_str += "1"
          else
            gen_str += "0"
        bin_total += parseInt(gen_str, 2)
        pitch = (bin_total % 127 ) + 1

        Array.prototype.push.apply(n_events, MidiEvent.createNote({ pitch: pitch }))

      t = new MidiTrack({ events: n_events })
      s = MidiWriter({ tracks: [t] })
      s.play()



$(document).ready ->
  $("#download-btn").click (e) ->
    e.preventDefault()
    window.song = MidiWriter({ tracks: window.tracks })
    window.song.save()

