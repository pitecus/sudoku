angular.module 'app'
.directive 'sudokuCell', [
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

          # Update cell values.
          $scope.isSelected = null
          updateCell = ->
            # Retrieve the data.
            $scope.values = SudokuService.getValue $scope.x, $scope.y

            # Check if is selected.
            $scope.isSelected = SudokuService.isSelected $scope.x, $scope.y

            # Check if was discovered.
            $scope.wasDiscovered = SudokuService.wasDiscovered $scope.x, $scope.y

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
