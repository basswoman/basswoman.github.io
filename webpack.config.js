var path = require('path');

module.exports = {
  mode: 'none',
  devServer: {
    contentBase: __dirname,
    compress: true,
    port: 9000
  }
};