angular.module 'app'
.controller 'SudokuCtrl',
[
  '$scope',
  'SudokuService',
  ($scope, SudokuService) ->
    # Add a listener for board changes.
    $scope.input = ''
    SudokuService.addListener ->
      # Update the results.
      results = SudokuService.getResults()
      arr = []
      for i in results
        arr.push i.join ', '
      $scope.input = arr.join '\n'

      # Return.
      true

    $scope.inputSolutions = ->
      arr = $scope.input.split '\n'
      for row in arr
        cell = row.split ', '
        SudokuService.setValue cell[0], cell[1], cell[2]

    $scope.setCellValue = (val) ->
      # Updated the selected cell.
      cell = SudokuService.getSelected()
      SudokuService.setValue cell.x, cell.y, val

      # Return.
      true
    # Return.
    true
]
