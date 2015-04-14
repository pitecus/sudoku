###*
 * Board factory.
###
angular.module 'app'
.factory 'BoardFactory', [ ->
  # The board values.
  _board = null

  # Selected cells.
  _select = {}

  ###*
   * Select key.
   *
   * @param  {Number} Row.
   * @param  {Number} Column.
   *
   * @return {String} Select key.
  ###
  _selectKey = (x, y) ->
    # Return.
    x + '' + y

  ###*
   * Reset the selection to none.
   * @return {undefined}
  ###
  _deselect = ->
    _select = {}

    # Return.
    return

  ###*
   * Initialize the board.
   *
   * @param  {Array}     Array of initial values.
   * @return {undefined}
  ###
  start: (vals) ->
    _board = {}

    for i in [1..9]
      _board[i] = []
      for j in [1..9]
        _board[i][j] =
          'values': [1, 2, 3, 4, 5, 6, 7, 8, 9]
          'discovered': false
          'x': i
          'y': j

    # Return.
    return


  #
  # Selection API.
  #

  ###*
   * Reset the selection to none.
   *
   * @return {undefined}
  ###
  deselect: _deselect

  ###*
   * Mark the cells as selected.
   * 
   * @param  {Array}     Array of cells to be set as selected.
   *
   * @return {undefined}
  ###
  selectCells: (cells) ->
    _deselect()
    for i in cells
      _select[_selectKey i.x, i.y] = true

    # Return.
    return



  ###*
   * Select cells that contains this values.
   * 
   * @param  {Array}  If a cell contains this value, it should be selected.
   *
   * @return {undefined}
  ###
  selectValues: (vals) ->
    _deselect()
    for i in [1..9]
      for j in [1..9]
        for k in vals
          _select[_selectKey i, j] = true if _board[i][j].values.indexOf(k) >= 0

    # Return.
    return

  ###*
   * Check if the cell is selected.
   * 
   * @param  {Number}  Row location.
   * @param  {Number}  Columns location.
   *
   * @return {Boolean} True if is selected, false otherwise.
  ###
  isSelected: (x, y) ->
    # Return.
    _select[_selectKey x, y]?


  #
  # Values API.
  #

  ###*
   * Return the cell values.
   *
   * @param  {Number} Row.
   * @param  {Number} Column.
   *
   * @return {Array}  Array of values.
  ###
  getValues: (x, y) ->
    # Return the values.
    _board[x][y].values

  ###*
   * Set cell values.
   *
   * @param  {Number} Row.
   * @param  {Number} Column.
   * @param  {Array}  Array of values.
   *
   * @return {undefined}
  ###
  setValues: (x, y, vals) ->
    _board[x][y].values = vals

    # Return.
    return
]
