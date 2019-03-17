# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

play_midi_b64_string = (b64String)->
  if b64String.indexOf("data:audio/midi;base64,") == -1
    b64String = "data:audio/midi;base64,#{b64String}"
  MIDI.loadPlugin(
    instrument: "acoustic_grand_piano"
    onsuccess: () =>
      MIDI.Player.loadFile(b64String, () ->
        MIDI.Player.start()
      )
  )

$(document).ready ->
  $(document).delegate ".cell", "click", (e) ->
    e.preventDefault()

    gen_id = $(@).data("gid")

    $(@).fadeOut 100, ->
      $(@).toggleClass("active").fadeIn(200)

    active = $(@).attr("data-active")
    if active == "true"
      $(@).attr("data-active", "false")
    else
      $(@).attr("data-active", "true")
      note_num = $(@).attr("data-num")
      note = $(".key-note[data-keynum=#{note_num}]").text()
      e = []
      Array.prototype.push.apply(e, MidiEvent.createNote(note))
      t = new MidiTrack({ events: e })
      s = MidiWriter({ tracks: [t] })
      play_midi_b64_string(s.b64)


    gen_str = ""
    $("#generation_#{gen_id} .cell").each (index, element) ->
      active = element.getAttribute("data-active")
      if active == "true"
        gen_str += "1"
      else
        gen_str += "0"
      
    $.ajax("/generations/#{gen_id}", {
      type: "PUT",
      dataType: "JSON",
      data: { generation: { current: gen_str} }
    })

