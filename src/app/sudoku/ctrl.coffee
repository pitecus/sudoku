angular.module 'app'
.controller 'SudokuCtrl',
[
  '$scope',
  'SudokuService',
  ($scope, SudokuService) ->
    # Selected cell.
    $scope.cellValue = null
    $scope.selected = null

    # Add a listener for board changes.
    SudokuService.addListener ->
      cell = SudokuService.getSelected()
      $scope.selected = SudokuService.getValue([cell.x], [cell.y])

      # Return.
      true

    # Update selected.
    $scope.updateValue = ->
      cell = SudokuService.getSelected()
      # Update value.
      val = parseInt $scope.cellValue, 10
      SudokuService.setValue cell.x, cell.y, val
      $scope.cellValue = null

      # Return.
      true
    # Return.
    true
]
