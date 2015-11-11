describe 'UtilA', ->
  UtilA = require '../../../../main/js/components/util/UtilA'
  describe 'getFoo', ->
    it 'returns foo', ->
      expect(new UtilA().getFoo()).toBe 'foo'