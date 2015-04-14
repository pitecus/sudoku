describe 'Board Services', ->

  # The board factory.
  board = null

  # Initialize the module app.
  beforeEach module 'app'

  # Inject the Board Factory.
  beforeEach inject (_BoardFactory_) ->
    board = _BoardFactory_

  # Test the board.
  describe 'Starting the board', ->
    # Reset the board values.
    beforeEach ->
      board.start()

    # 1 cell selection.
    it 'should return true if the cell is selected', ->
      # Initial selected cells.
      board.selectCells [
          'x': 1
          'y': 1
      ]

      # Positive tests.
      isSelected = board.isSelected 1, 1
      assert.ok isSelected, 'cell [1, 1] is selected'
      # Negative tests.
      isSelected = board.isSelected 1, 2
      assert.notOk isSelected, 'cell [1, 2] is not selected'
      isSelected = board.isSelected 2, 1
      assert.notOk isSelected, 'cell [1, 2] is not selected'
      isSelected = board.isSelected 2, 2
      assert.notOk isSelected, 'cell [1, 2] is not selected'

    # 2 cells selection.
    it 'should return true if the cells are selected', ->
      # Initial selected cells.
      board.selectCells [
          'x': 1
          'y': 1
        ,
          'x': 9
          'y': 9
      ]

      # Positve tests.
      isSelected = board.isSelected 1, 1
      assert.ok isSelected, 'cell [1, 1] is selected'
      isSelected = board.isSelected 9, 9
      assert.ok isSelected, 'cell [9, 9] is selected'

      # Negative tests.
      isSelected = board.isSelected 1, 2
      assert.notOk isSelected, 'cell [1, 2] is not selected'
      isSelected = board.isSelected 2, 1
      assert.notOk isSelected, 'cell [1, 2] is not selected'
      isSelected = board.isSelected 2, 2
      assert.notOk isSelected, 'cell [2, 2] is not selected'
      isSelected = board.isSelected 8, 9
      assert.notOk isSelected, 'cell [8, 9] is not selected'
      isSelected = board.isSelected 9, 8
      assert.notOk isSelected, 'cell [9, 8] is not selected'
      isSelected = board.isSelected 8, 8
      assert.notOk isSelected, 'cell [8, 8] is not selected'

    # Set values to a cell.
    it 'should return the setup values', ->
      # Change the value to not match.
      board.setValues 1, 2, [3]

      # Positve tests.
      vals = board.getValues 1, 2
      assert.ok vals.length == 1, 'cell [1, 2] has one value'
      assert.ok vals[0] == 3, 'cell [1, 2] has the value 3'

      # Negative tests.
      vals = board.getValues 1, 1
      assert.ok vals.length == 9, 'cell [1, 1] has 9 values'

    # 2 value selection.
    it 'should return true if the cells contains this value', ->
      # Change the value to not match.
      board.setValues 1, 2, [3]
      board.setValues 2, 3, [4]

      # Select all cells with values 1 and 2.
      board.selectValues [1, 4]

      # Positve tests.
      isSelected = board.isSelected 1, 1
      assert.ok isSelected, 'cell [1, 1] is selected'
      isSelected = board.isSelected 9, 9
      assert.ok isSelected, 'cell [9, 9] is selected'

      # Negative tests.
      isSelected = board.isSelected 1, 2
      assert.notOk isSelected, 'cell [1, 2] is selected'
      isSelected = board.isSelected 2, 3
      assert.ok isSelected, 'cell [2, 3] is not selected'