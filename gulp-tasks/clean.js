var
  del;

del = require('del');

module.exports = function (gulp, plugins, paths) {
  return function () {
    del([paths.dest.dist]);
  };
};
