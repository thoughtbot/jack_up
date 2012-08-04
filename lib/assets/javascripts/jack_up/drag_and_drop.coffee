ignoreEvent = (event) ->
  event.stopPropagation()
  event.preventDefault()

class @JackUp.DragAndDrop
  constructor: (@droppableElement, @processor) ->
    @droppableElement
      .bind("dragenter", @_dragEnter)
      .bind("dragleave", @_dragLeave)
      .bind("drop", @_drop)

  _dragEnter: (event) =>
    ignoreEvent event
    event.originalEvent.dataTransfer.dropEffect = "copy"
    @droppableElement.addClass("hover")

  _dragLeave: (event) =>
    ignoreEvent event
    @droppableElement.removeClass("hover")

  _drop: (event) =>
    ignoreEvent event
    @droppableElement.removeClass("hover")
    @droppableElement.find('[data-placeholder]').hide()
    @processor.processFilesForEvent(event)
