describe 'Board Services', ->

  board = null

  beforeEach module 'app'

  beforeEach inject (_BoardFactory_) ->
    board = _BoardFactory_

  describe 'Starting the board', ->
    beforeEach ->
      board.start()

    it 'should return -1 when the value is not present', ->
      board.select [
          'x': 1
          'y': 1
      ]
      isSelected = board.isSelected 1, 1
      console.log 'isSelected', isSelected
      assert.ok isSelected, 'cell is selected'
