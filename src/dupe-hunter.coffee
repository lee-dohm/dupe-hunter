module.exports =
  uriEncode: (text) ->
    encodeURI(text).replace(/#/g, '%23').replace(/;/g, '%3B')

  getApiUrl: ->
    'https://api.github.com/search/issues'
