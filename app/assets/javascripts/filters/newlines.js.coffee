Chekhov.filter "newlines", @newlines = () ->
  (text) ->
    text.replace /\r\n|\r|\n/g, "<br />"
