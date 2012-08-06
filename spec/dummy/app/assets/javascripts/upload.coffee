$ ->
  processor = new JackUp.Processor(path: '/assets')

  processor.on 'upload:imageRenderReady', (e, options) ->
    options.image.attr("data-id", options.file.__guid__).css(border: '5px solid red')
    $('.attachments').append(options.image)

  processor.on "upload:sentToServer", (e, options) ->
    $("img[data-id='#{options.file.__guid__}']").css(borderColor: 'yellow')

  processor.on "upload:success", (e, options) ->
    $("img[data-id='#{options.file.__guid__}']").css(borderColor: "green")

  $("[name='upload']").jackUpAjax(processor)
