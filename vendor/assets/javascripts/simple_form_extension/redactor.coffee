class Redactor
  DEFAULT_OPTIONS: {
    min_height: 250
  }

  constructor: (@$el) ->
    params = @params()
    config = $.extend({}, @DEFAULT_OPTIONS, @$el.data('redactor-config'))

    console.log('REDACTOR CONFIG : ', config, ' //// ', @DEFAULT_OPTIONS)

    @$el.redactor
      buttons: ['html', 'formatting',  'bold', 'italic', 'underline', 'deleted',
        'unorderedlist', 'orderedlist', 'outdent', 'indent',
        'image', 'file','link', 'alignment', 'horizontalrule']
      removeEmpty: ['strong', 'em', 'span', 'p', 'h1', 'h2', 'h3', 'h4', 'div']
      minHeight: config.min_height
      maxHeight: 400
      buttonSource: true
      replaceDivs: false
      linebreaks: false
      toolbarFixed: false
      formattingAdd: [
        {
          tag: 'img'
          title: 'Image 100%'
          class: 'img-responsive'
        }
      ]
      imageUpload: ["/redactor_rails/pictures", params].join('?')
      imageManagerJson: "/redactor_rails/pictures"
      fileUpload: ["/redactor_rails/documents", params].join('?')
      fileManagerJson: "/redactor_rails/documents"
      plugins: [
        "clips"
        "video"
        "table"
        "fontcolor"
        "fontsize"
        "fontfamily"
        "scriptbuttons"
        "imagepx"
      ]
      path: "/assets/redactor-rails"
      lang: "fr"

  params: ->
    csrf_token = $('meta[name=csrf-token]').attr('content')
    csrf_param = $('meta[name=csrf-param]').attr('content')

    params = if (csrf_param isnt undefined and csrf_token isnt undefined)
      csrf_param + "=" + encodeURIComponent(csrf_token);

    params

$.fn.simpleFormRedactor = ->
  @each (i, el) ->
    $textarea = $(el)
    return if $textarea.data('simple-form:redactor')
    instance = new Redactor($textarea)
    $textarea.data('simple-form:redactor', instance)

$.simpleForm.onDomReady ($document) ->
  $document.find('[data-redactor]').simpleFormRedactor()
