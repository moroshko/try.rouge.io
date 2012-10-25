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
    paren = -1
    string = false
    quote = false
    for c in entered
      if c == " "
        $('span.entry').append("&nbsp;")
      else if string
        if quote
          $('span.entry').append("<span class='string'>#{c}</span>")
          quote = false
        else if c == "\\"
          $('span.entry').append("<span class='string'>\\</span>")
          quote = true
        else if c == "\""
          $('span.entry').append("<span class='string'>\"</span>")
          string = false
        else
          $('span.entry').append("<span class='string'>#{c}</span>")
      else if c == "\""
        $('span.entry').append("<span class='string'>\"</span>")
        string = true
      else if c == "("
        paren += 1
        $('span.entry').append("<span class='paren#{paren % 4}'>(</span>")
      else if c == ")"
        $('span.entry').append("<span class='paren#{paren % 4}'>)</span>")
        paren -= 1
      else
        $('span.entry').append(c)

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
