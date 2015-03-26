'use strict';
var
  app;

app = angular.module('app', ['ui.bootstrap'], [ function() {
  console.log('app.js: initialized app module');
}]);

app.controller('SudokuCtrl', ['$scope', 'boardService', function($scope, boardService) {
  // Selected cell.
  $scope.cellValue = null;
  $scope.selected = null;

  // Add a listener for board changes.
  boardService.addListener(function () {
    var
      cell;

    cell = boardService.getSelected();
    $scope.selected = boardService.getValue([cell.x], [cell.y]);
  });

  // Update selected.
  $scope.updateValue = function () {
    var
      cell;

    cell = boardService.getSelected();
    // Update value.
    boardService.setValue(cell.x, cell.y, parseInt($scope.cellValue, 10));
    $scope.cellValue = null;
  };

}]);

app.directive('sudokuCell', [ 'boardService', function(boardService) {
  var
    directive;

  // Setup directive.
  directive = {
    'restrict': 'E',
    'controller': ['$scope', '$attrs', function($scope, $attrs) {
      var
        updateCell;

      // Select one cell.
      $scope.select = function () {
        boardService.setSelected($scope.x, $scope.y);
      }

      // Retrieve the values from the board service.
      updateCell = function () {
        var
          val;

        val = boardService.getValue($scope.x, $scope.y);
        if (val.length === 1) {
          $scope.values = val[0];
        } else {
          $scope.values = val;
        }
      };
      updateCell();

      // Listen for events.
      boardService.addListener(updateCell);
    }],
    'templateUrl': 'cell.html'
  };

  // Return.
  return directive;
}]);

app.service('boardService', [function() {
  var
    // The board.
    board,
    initialize,
    // Clean up crew.
    cleanupValues,
    removeCellValue,
    // Listeners for changes.
    selected,
    listeners,
    notify;

  /**
   * Initalize the board with default values.
   * @return {boolean} Always return true.
   */
  initialize = function () {
    var
      row,
      col;

    // Populate the sudoku with all possible values.
    board = [];
    for (row = 0; row < 9; row += 1) {
      board[row] = []
      for (col = 0; col < 9; col += 1) {
        board[row][col] = {
          'values': [1, 2, 3, 4, 5, 6, 7, 8, 9],
          'evaluated': false,
          'x': row,
          'y': col
        };
      }
    }

    // Return.
    return true;
  };
  initialize();

  this.getValue = function (x, y) {
    // Return the value.
    return board[x][y].values;
  };

  this.setValue = function (x, y, val) {
    var
      process,
      cell;

    // Process all the new values.
    process = [
      {
        'x': x,
        'y': y,
        'val': val
      }
    ];
    while (process.length > 0){
      cell = process.pop();

      // Set the value.
      board[cell.x][cell.y].values = cell.val;
      board[cell.x][cell.y].evaluated = true;

      // Update values.
      Array.prototype.push.apply(process, cleanupValues(cell.x, cell.y, cell.val));
    }

    // Notify about change.
    notify();

    // Return null.
    return null;
  }

  removeCellValue = function (values, val) {
    var
      index;

    index = values.indexOf(val);
    if (index >= 0) {
      values.splice(index, 1);
    }
  };

  cleanupValues = function (x, y, val) {
    var
      i,
      j,
      offx,
      offy,
      reprocess;

    // Store fields to re-process.
    reprocess = [];

    // Remove the value from a row.
    for (i = 0; i < 9; i += 1) {
      if (i !== y) {
        if (board[x][i].evaluated === false) {
          removeCellValue(board[x][i].values, val);
          if (board[x][i].values.length === 1) {
            reprocess.push({
              'x': x,
              'y': i,
              'val': board[x][i].values[0]
            });
          }
        }
      }
    }

    // Remove the value from a column.
    for (i = 0; i < 9; i += 1) {
      if (i !== x) {
        if (board[i][y].evaluated === false) {
          removeCellValue(board[i][y].values, val);
          if (board[i][y].values.length === 1) {
            reprocess.push({
              'x': i,
              'y': y,
              'val': board[i][y].values[0]}
            );
          }
        }
      }
    }

    // Remove the value from the block.
    offx = Math.floor(x / 3) * 3;
    offy = Math.floor(y / 3) * 3;
    for (i = 0; i < 3; i += 1) {
      for (j = 0; j < 3; j += 1) {
        if ((i + offx) != x && (j + offy) != y) {
          if (board[i + offx][j + offy].evaluated === false) {
            removeCellValue(board[i + offx][j + offy].values, val);
            if (board[i + offx][j + offy].values.length === 1) {
              reprocess.push({
                'x': i + offx,
                'y': j + offy,
                'val': board[i + offx][j + offy].values[0]
              });
            }
          }
        }
      }
    }

    // Return the new discovered fields.
    return reprocess;
  };

  selected = null;

  listeners = [];

  notify = function () {
    var
      len,
      i;

    len = listeners.length;
    for (i = 0; i < len; i += 1) {
      listeners[i]();
    };
  };

  this.setSelected = function (x, y) {
    selected = {
      'x': x,
      'y': y
    };
    notify();
  };

  this.getSelected = function () {
    return selected;
  }

  this.addListener = function (cb) {
    listeners.push(cb);
  };
}]);
