angular.module 'app'
.service 'SudokuService', [ ->
  board = null
  initialize = undefined
  _cleanupValues = undefined
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
          'discovered': false
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
    board[x][y].values

  @wasDiscovered = (x, y) ->
    # Return if is was discovered.
    board[x][y].discovered

  setDiscovered = (x, y) ->
    board[x][y].discovered = true

  ###*
   * Set the value in the board.
   * @param {Number} x   Row location.
   * @param {Number} y   Column location.
   * @param {null}   val [description]
  ###
  @setValue = (x, y, val) ->
    # Process all the new values.
    process = [ {
      'x': x
      'y': y
      'val': parseInt val, 10
    } ]

    while process.length > 0
      # Remove the cell.
      cell = process.pop()

      # Set the value.
      board[cell.x][cell.y].values = [cell.val]
      board[cell.x][cell.y].evaluated = true

      # Update values.
      Array.prototype.push.apply process, _cleanupValues(cell.x, cell.y, cell.val)

      # Look for unique values.
      if process.length == 0
        Array.prototype.push.apply process, _uniqueVals()

    # Notify about change.
    notify()

    # Return.
    return

  ###*
   * Set the value in the board.
   * @param {Number} x   Row location.
   * @param {Number} y   Column location.
   * @param {null}   val [description]
  ###
  @setValues = (x, y, vals) ->
    board[x][y].values = vals

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
  _cleanupValues = (x, y, val) ->
    # Store fields to re-process.
    reprocess = []
    # Remove the value from a row.
    i = 0
    while i < 9
      if i != y
        if board[x][i].evaluated == false
          removeCellValue board[x][i].values, val
          if board[x][i].values.length == 1
            setDiscovered x, i
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
            setDiscovered i, y
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
              setDiscovered i + offx, j + offy
              reprocess.push
                'x': i + offx
                'y': j + offy
                'val': board[i + offx][j + offy].values[0]
        j += 1
      i += 1

    # Return the new discovered fields.
    reprocess

  _uniqueValsToReprocess = (vals) ->
    reprocess = []
    for k, v of vals
      if v.length == 1
        setDiscovered v[0].x, v[0].y
        reprocess.push
          'x': v[0].x
          'y': v[0].y
          'val': parseInt k, 10
    # Return.
    reprocess

  ###*
   * Loop through each row, col and block looking for lonely values to prey.
   * @return {[type]} [description]
  ###
  _uniqueVals = ->
    # Store fields to re-process.
    reprocess = []

    # Remove the value from a row.
    i = 0
    # External loop.
    while i < 9
      j = 0
      # Internal loop.
      rows = {}
      cols = {}
      block = {}

      # Find the offsets.
      offy = Math.floor(i / 3) * 3
      offx = (i % 3) * 3

      while j < 9
        # Rows.
        if board[i][j].evaluated == false
          k = board[i][j].values.length - 1
          while k >= 0
            if rows[board[i][j].values[k]]?
              rows[board[i][j].values[k]].push board[i][j]
            else
              rows[board[i][j].values[k]] = [board[i][j]]
            k -= 1

        # Columns.
        if board[j][i].evaluated == false
          k = board[j][i].values.length - 1
          while k >= 0
            if cols[board[j][i].values[k]]?
              cols[board[j][i].values[k]].push board[j][i]
            else
             cols[board[j][i].values[k]] = [board[j][i]]
            k -= 1

        # Block.
        x = Math.floor(j / 3) + offx
        y = (j % 3) + offy
        if board[x][y].evaluated == false
          k = board[x][y].values.length - 1
          while k >= 0
            if block[board[x][y].values[k]]?
              block[board[x][y].values[k]].push board[x][y]
            else
             block[board[x][y].values[k]] = [board[x][y]]
            k -= 1

        # Update index.
        j += 1

      # All the single keys.
      Array.prototype.push.apply reprocess, _uniqueValsToReprocess rows
      Array.prototype.push.apply reprocess, _uniqueValsToReprocess cols
      Array.prototype.push.apply reprocess, _uniqueValsToReprocess block

      # Update index.
      i += 1

    # Return.
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
   * Set the selected cell in the board.
   * @param  {Number} x   Row location.
   * @param  {Number} y   Column location.
  ###
  @isSelected = (x, y) ->
    return selected?.x == x and selected?.y == y

  ###*
   * Return the selected cell location.
   * @return {[type]} [description]
  ###
  @getSelected = ->
    selected


  @getResults = ->
    results = []
    row = 0
    while row < 9
      col = 0
      while col < 9
        cell = board[row][col]
        if cell.discovered == false and cell.evaluated == true
          results.push [row, col, board[row][col].values[0]]

        # Update index.
        col += 1

      # Update index.
      row += 1

    # Return.
    results

  return
 ]
