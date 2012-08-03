getFilesFromEvent = (event) ->
  if event.originalEvent.dataTransfer?
    event.originalEvent.dataTransfer.files
  else if event.originalEvent.currentTarget? && event.originalEvent.currentTarget.files?
    event.originalEvent.currentTarget.files
  else if event.originalEvent.target? && event.originalEvent.target.files?
    event.originalEvent.target.files
  else
    []

filesWithData = (event) ->
  _.map getFilesFromEvent(event), (file) ->
    file.__guid__ = Math.random().toString(36)
    file

class @JackUp.Processor
  constructor: (options) ->
    @uploadPath = options.path

  processFilesForEvent: (event) =>
    _.each filesWithData(event), (file) =>
      reader = new FileReader()
      reader.onload = (event) =>
        @trigger 'upload:dataRenderReady', result: event.target.result, file: file

        if /^data:image/.test event.target.result
          image = $("<img>").attr("src", event.target.result)
          @trigger 'upload:imageRenderReady', image: image, file: file

      reader.readAsDataURL(file)

      fileUploader = new JackUp.FileUploader(path: @uploadPath)
      @bubble 'upload:start', 'upload:success', 'upload:failure', 'upload:sentToServer',
        from: fileUploader

      fileUploader.upload file

_.extend JackUp.Processor.prototype, JackUp.Events
