# angular.module 'app',
# ['ui.bootstrap'],
# [ ->
#   console.log 'app.js: initialized app module'

#   # Return.
#   true
# ]

angular.module 'app'
.factory 'BoardFactory', [ ->
  # The board values.
  _board = null

  # Selected cells.
  _select = {}

  # Select key.
  _selectKey = (x, y) ->
    # Return.
    x + '' + y

  # Initialize the board.
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
    true

  select: (cells) ->
    _select = {}
    for i in cells
      key = _selectKey i.x, i.y
      _select[key] = true
    console.log _select

    # Return.
    true

  isSelected: (x, y) ->
    # Return.
    key = _selectKey x, y
    _select[key]?
]
