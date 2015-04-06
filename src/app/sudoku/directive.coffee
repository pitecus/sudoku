angular.module 'app'
.directive 'sudokuDirective', [
  'boardService'
  (boardService) ->
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
            boardService.setSelected $scope.x, $scope.y

            # Return.
            return

          # Retrieve the values from the board service.

          updateCell = ->
            val = undefined
            val = boardService.getValue($scope.x, $scope.y)
            if val.length == 1
              $scope.values = val[0]
            else
              $scope.values = val

            # Return.
            return

          updateCell()
          # Listen for events.
          boardService.addListener updateCell

          # Return.
          return
      ]
      'templateUrl': 'cell.html'
    # Return.
    directive
]
