$ = require 'jquery'

module.exports =
  # Public: Finds issues that match the given text.
  #
  # It defaults to searching all repositories under the Atom user.
  #
  # * `text` Text {String} to search for.
  # * `options` (optional) {Object} An options hash
  #     * `user` Name {String} of user in which to search
  #     * `repo` User and repo {String} in which to search (format: `name/repo`, ex: `atom/atom`)
  #
  # Returns a {Promise} that resolves to an {Object} containing:
  #     * `closed` Oldest closed matching issue
  #     * `open` Oldest open matching issue
  findSimilarIssues: (text, options = {}) ->
    query = @formatQuery(text, options)

    new Promise (resolve, reject) =>
      $.ajax "#{@getApiUrl()}?q=#{@uriEncode(query)}&sort=created",
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

  # Private: Formats the query based on the options.
  #
  # * `text` Text {String} to search for.
  # * `options` (optional) {Object} An options hash
  #     * `user` Name {String} of user in which to search
  #     * `repo` User and repo {String} in which to search (format: `name/repo`, ex: `atom/atom`)
  #
  # Returns the query {String}.
  formatQuery: (text, options) ->
    switch
      when options.repo?
        "#{text} repo:#{options.repo}"
      when options.user?
        "#{text} user:#{options.user}"
      else
        "#{text} user:atom"

  # Private: Gets the API URL.
  #
  # Returns the API URL {String}.
  getApiUrl: ->
    'https://api.github.com/search/issues'

  # Private: Converts the given `text` to a URI-safe format.
  #
  # Returns the encoded {String}.
  uriEncode: (text) ->
    encodeURI(text).replace(/#/g, '%23').replace(/;/g, '%3B')
