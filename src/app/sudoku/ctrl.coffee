angular.module 'app'
.controller 'SudokuCtrl',
[
  '$scope',
  'boardService',
  ($scope, boardService) ->
    # Selected cell.
    $scope.cellValue = null
    $scope.selected = null

    # Add a listener for board changes.
    boardService.addListener ->
      cell = boardService.getSelected()
      $scope.selected = boardService.getValue([cell.x], [cell.y])

      # Return.
      true

    # Update selected.
    $scope.updateValue = ->
      cell = boardService.getSelected()
      # Update value.
      val = parseInt $scope.cellValue, 10
      boardService.setValue cell.x, cell.y, val
      $scope.cellValue = null

      # Return.
      true
    # Return.
    true
]
