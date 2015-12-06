angular.module 'app'
.controller 'SudokuCtrl',
[
  '$scope',
  'SudokuService',
  ($scope, SudokuService) ->
    _selected = null
    # Add a listener for board changes.
    $scope.input = ''
    $scope.values = ''
    SudokuService.addListener ->
      # Update the selection.
      _a = SudokuService.getSelected()
      if _a?
        _a = SudokuService.getValue _a.x, _a.y
        $scope.values = _a.join ', '

      # Update the results.
      results = SudokuService.getResults()
      arr = []
      for i in results
        arr.push i.join ', '
      $scope.input = arr.join '\n'

      # Return.
      return

    $scope.setValues = ->
      _a = SudokuService.getSelected()
      _b = $scope.values.split ', '
      .map (a) ->
        return parseInt a, 10
      console.log _b
      SudokuService.setValues _a.x, _a.y, _b
      $scope.values = ''
      # Return.
      return

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
      return

    # Return.
    return
]
