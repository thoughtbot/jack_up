@JackUp.Events =
  trigger: ->
    $(@).trigger arguments...

  on: ->
    $(@).bind arguments...

  bubble: (eventList..., options) ->
    _.each eventList, (eventName) =>
      options.from.on eventName, =>
        @trigger eventName, arguments[1]
