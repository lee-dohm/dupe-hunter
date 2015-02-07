hunter = require '../lib/dupe-hunter'

describe "DupeHunter", ->
  describe 'encodeURI', ->
    it 'encodes the text', ->
      text = 'some test text'

      expect(hunter.encodeURI(text)).toEqual(encodeURI(text))

    it 'encodes # as %23', ->
      text = 'issue#123'

      expect(hunter.encodeURI(text)).toEqual(text.replace(/#/g, '%23'))

    it 'encodes ; as %3B', ->
      text = 'foo;bar'

      expect(hunter.encodeURI(text)).toEqual(text.replace(/;/, '%3B'))

  describe 'getApiUrl', ->
    it 'returns the issue search url', ->
      expect(hunter.getApiUrl()).toEqual('https://api.github.com/search/issues')
