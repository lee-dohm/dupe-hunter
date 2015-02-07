$ = require 'jquery'

module.exports =
  findSimilarIssues: (text) ->
    query = "#{text} user:atom"

    new Promise (resolve, reject) =>
      $.ajax "#{@getApiUrl()}?q=#{@uriEncode(query)}",
        accept: 'application/vnd.github.v3+json'
        contentType: 'application/json'
        success: (data) ->
          if data.items?
            issues = {}
            for issue in data.items
              if issue.title.indexOf(text) > -1 and not issues[issue.state]?
                issues[issue.state] = issue
            return resolve(issues) if issues.open? or issues.closed?
          resolve(null)
        error: (e) -> reject(e)

  getApiUrl: ->
    'https://api.github.com/search/issues'

  uriEncode: (text) ->
    encodeURI(text).replace(/#/g, '%23').replace(/;/g, '%3B')
