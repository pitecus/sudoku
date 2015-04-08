angular.module 'app'
.service 'SudokuService', [ ->
  board = null
  initialize = undefined
  cleanupValues = undefined
  removeCellValue = undefined
  selected = undefined
  listeners = undefined
  notify = undefined

  ###*
  # Initalize the board with default values.
  # @return {boolean} Always return true.
  ###
  initialize = ->
    # Populate the sudoku with all possible values.
    board = []
    row = 0
    while row < 9
      board[row] = []
      col = 0
      while col < 9
        board[row][col] =
          'values': [
            1
            2
            3
            4
            5
            6
            7
            8
            9
          ]
          'evaluated': false
          'x': row
          'y': col
        col += 1
      row += 1

    # Return.
    return
  # Initialize the board.
  initialize()

  ###*
   * Return the value of the board.
   * @param  {Number} x Row location.
   * @param  {Number} y Column location.
   * @return {null}   [description]
  ###
  @getValue = (x, y) ->
    # Return the value.
    # console.log x, y, board[x][y].values
    board[x][y].values

  ###*
   * Set the value in the board.
   * @param {Number} x   Row location.
   * @param {Number} y   Column location.
   * @param {null}   val [description]
  ###
  @setValue = (x, y, val) ->
    cell = null

    # Process all the new values.
    process = [ {
      'x': x
      'y': y
      'val': val
    } ]

    while process.length > 0
      # Remove the cell.
      cell = process.pop()

      # Set the value.
      board[cell.x][cell.y].values = [cell.val]
      board[cell.x][cell.y].evaluated = true

      # Update values.
      Array.prototype.push.apply process, cleanupValues(cell.x, cell.y, cell.val)

    # Notify about change.
    notify()

    # Return.
    return

  ###*
   * Remove the value from a specific cell.
   * @param  {Array}  values List of possible values in this cell.
   * @param  {Number} val    The number to be removed from the list.
   * @return {null}
  ###
  removeCellValue = (values, val) ->
    index = values.indexOf(val)
    if index >= 0
      values.splice index, 1
    return

  ###*
   * Remove values known to not be valid.
   * @param  {Number} x   Row location.
   * @param  {Number} y   Column location.
   * @param  {Number} val Value to be removed from the board.
   * @return {Array}      Cells to be reprocessed.
  ###
  cleanupValues = (x, y, val) ->
    # Store fields to re-process.
    reprocess = []
    # Remove the value from a row.
    i = 0
    while i < 9
      if i != y
        if board[x][i].evaluated == false
          removeCellValue board[x][i].values, val
          if board[x][i].values.length == 1
            reprocess.push
              'x': x
              'y': i
              'val': board[x][i].values[0]
      i += 1

    # Remove the value from a column.
    i = 0
    while i < 9
      if i != x
        if board[i][y].evaluated == false
          removeCellValue board[i][y].values, val
          if board[i][y].values.length == 1
            reprocess.push
              'x': i
              'y': y
              'val': board[i][y].values[0]
      i += 1

    # Remove the value from the block.
    offx = Math.floor(x / 3) * 3
    offy = Math.floor(y / 3) * 3
    i = 0
    while i < 3
      j = 0
      while j < 3
        if i + offx != x and j + offy != y
          if board[i + offx][j + offy].evaluated == false
            removeCellValue board[i + offx][j + offy].values, val
            if board[i + offx][j + offy].values.length == 1
              reprocess.push
                'x': i + offx
                'y': j + offy
                'val': board[i + offx][j + offy].values[0]
        j += 1
      i += 1

    # Return the new discovered fields.
    reprocess

  selected = null
  listeners = []

  ###*
   * Notify the observers about the change.
   * @return {[type]} [description]
  ###
  notify = ->
    len = undefined
    i = undefined
    len = listeners.length
    i = 0
    while i < len
      listeners[i]()
      i += 1
    return

  ###*
   * [addListener description]
   * @param {Function} cb [description]
  ###
  @addListener = (cb) ->
    listeners.push cb
    return

  ###*
   * Set the selected cell in the board.
   * @param  {Number} x   Row location.
   * @param  {Number} y   Column location.
  ###
  @setSelected = (x, y) ->
    selected =
      'x': x
      'y': y
    notify()
    return

  ###*
   * Return the selected cell location.
   * @return {[type]} [description]
  ###
  @getSelected = ->
    selected

  return
 ]
