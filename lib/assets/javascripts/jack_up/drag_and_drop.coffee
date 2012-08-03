ignoreEvent = (event) ->
  event.stopPropagation()
  event.preventDefault()

class @JackUp.DragAndDrop
  constructor: (@droppableElement, @processor) ->
    @droppableElement
      .bind("dragenter", @_drag)
      .bind("drop", @_drop)
      .bind("drop", @_dragOut)

  _drag: (event) =>
    ignoreEvent event
    event.originalEvent.dataTransfer.dropEffect = "copy"
    @droppableElement.addClass("hover")

  _dragOut: (event) =>
    ignoreEvent event
    @droppableElement.removeClass("hover")

  _drop: (event) =>
    ignoreEvent event
    @droppableElement.find('[data-placeholder]').hide()
    @processor.processFilesForEvent(event)
