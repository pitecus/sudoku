###*
 * Board factory.
###
angular.module 'app'
.factory 'BoardFactory', [ ->
  # The board values.
  _board = null


  #
  # Initialize the board.
  #

  ###*
   * Initialize the board.
   *
   * @param  {Array}     Array of initial values.
   * @return {undefined}
  ###
  start = (vals) ->
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
   * Reset the selection to none.
   *
   * @return {undefined}
  ###
  deselect =  ->
    _deselect()

  ###*
   * Mark the cells as selected.
   *
   * @param  {Array}     Array of cells to be set as selected.
   *
   * @return {undefined}
  ###
  selectCells = (cells) ->
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
  selectValues = (vals) ->
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
  isSelected = (x, y) ->
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
  getValues = (x, y) ->
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
  setValues = (x, y, vals) ->
    oldVals = _board[x][y].values
    _board[x][y].values = vals

    # Notify the listeners.
    _notify 'change', [
        'x': x
        'y': y
        'values': oldVals
      ,
        'x': x
        'y': y
        'values': vals
    ]

    # Return.
    return


  #
  # Observer pattern.
  #

  # Events notification.
  _events = null
  _resetListeners = ->
    _events = {
      'all': []
    }
  _resetListeners()

  _notify = (event, data) ->
    for i in ['all', event]
      # Notify the listeners.
      cb i, data for cb in _events[i] if _events[i]?

  ###*
   * Add a listener for an event.
   * Events are: 'change', 'selected', 'deselected'
   *
   * @param {String}   event Event name.
   * @param {Function} cb    Callback when the event happens.
   *
   * @returns {undefined} Nothing is returned.
  ###
  addListener = (event, cb) ->
    # Create an array of events.
    if !_events[event]?
      _events[event] = []

    # Add listener to the queue.
    _events[event].push cb

    # Return.
    return

  removeListeners = ->
    _resetListeners()


  # Return.
  'start': start
  # Selection API.
  'deselect': deselect
  'isSelected': isSelected
  'selectCells': selectCells
  'selectValues': selectValues
  # Values API.
  'getValues': getValues
  'setValues': setValues
  # Observer pattern.
  'addListener': addListener
  'removeListeners': removeListeners

]
