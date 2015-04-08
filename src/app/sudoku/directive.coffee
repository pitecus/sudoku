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
            $scope.values = SudokuService.getValue($scope.x, $scope.y)

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
