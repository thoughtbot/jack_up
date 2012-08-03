$.fn.jackUpAjax = (processor) ->
  $(@).change(processor.processFilesForEvent)
  @

$.fn.jackUpDragAndDrop = (processor) ->
  new JackUp.DragAndDrop($(@), processor)
  @
