hunter = require '../lib/dupe-hunter'

describe "DupeHunter", ->
  describe 'uriEncode', ->
    it 'encodes the text', ->
      text = 'some test text'

      expect(hunter.uriEncode(text)).toEqual(encodeURI(text))

    it 'encodes # as %23', ->
      text = 'issue#123'

      expect(hunter.uriEncode(text)).toEqual(text.replace(/#/, '%23'))

    it 'encodes ; as %3B', ->
      text = 'foo;bar'

      expect(hunter.uriEncode(text)).toEqual(text.replace(/;/, '%3B'))

  describe 'getApiUrl', ->
    it 'returns the issue search url', ->
      expect(hunter.getApiUrl()).toEqual('https://api.github.com/search/issues')

  describe 'formatQuery', ->
    it 'defaults to searching within user atom', ->
      expect(hunter.formatQuery('foo')).toEqual('foo user:atom')

    it 'can search within another user', ->
      expect(hunter.formatQuery('foo', user: 'some-guy')).toEqual('foo user:some-guy')

    it 'can search within a repo', ->
      expect(hunter.formatQuery('foo', repo: 'bar/baz')).toEqual('foo repo:bar/baz')

    it 'prefers repo over user', ->
      expect(hunter.formatQuery('foo', repo: 'bar/baz', user: 'dude')).toEqual('foo repo:bar/baz')
