$ ->
  cursorInterval = undefined
  resetCursor = ->
    clearInterval(cursorInterval)
    $('span.cursor').show()
    cursorInterval = setInterval( ->
      $('span.cursor').toggle()
    , 1000)

  resetCursor()

  entered = ""

  updateEntry = ->
    resetCursor()
    $('span.entry').empty()
    e = entered
    while e.length > 0
      nextSpace = e.indexOf(" ")
      if nextSpace == 0
        $('span.entry').append("&nbsp;")
        e = e.substr(1)
      else if nextSpace > 0
        $('span.entry').append($("<span></span>").text(e.substr(0, nextSpace)))
        $('span.entry').append("&nbsp;")
        e = e.substr(nextSpace + 1)
      else
        $('span.entry').append(e)
        e = ""

  $('body').keydown (e) ->
    if e.keyCode == 8
      entered = entered.substr(0, entered.length - 1)
      updateEntry()
      e.preventDefault()
    else if e.keyCode == 13
      e.preventDefault()
    else if e.keyCode == 9
      entered += "\t"
      updateEntry()
      e.preventDefault()

  $('body').keypress (e) ->
    if e.which == 21
      entered = ""
    else if e.which < 32
      return

    entered += String.fromCharCode(e.which)
    updateEntry()
