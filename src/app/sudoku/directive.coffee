angular.module 'app'
.directive 'sudokuDirective', [
  'SudokuService'
  (SudokuService) ->
    directive = undefined
    # Setup directive.
    directive =
      'restrict': 'E'
      'controller': [
        '$scope'
        '$attrs'
        ($scope, $attrs) ->
          updateCell = undefined
          # Select one cell.

          $scope.select = ->
            SudokuService.setSelected $scope.x, $scope.y

            # Return.
            return

          # Retrieve the values from the board service.
          updateCell = ->
            val = undefined
            val = SudokuService.getValue($scope.x, $scope.y)
            if val.length == 1
              $scope.values = val[0]
            else
              $scope.values = val

            # Return.
            return

          updateCell()
          # Listen for events.
          SudokuService.addListener updateCell

          # Return.
          return
      ]
      'templateUrl': 'templates/cell.html'
    # Return.
    directive
]
console.log 'yarr'
