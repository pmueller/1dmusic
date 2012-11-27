# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $(document).delegate ".cell", "click", (e) ->
    e.preventDefault()
    gen_id = $(@).data("gid")

    $(@).toggleClass("active")
    active = $(@).attr("data-active")
    if active == "true"
      $(@).attr("data-active", "false")
    else
      $(@).attr("data-active", "true")

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

