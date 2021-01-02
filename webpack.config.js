var path = require('path');

module.exports = {
  mode: 'none',
  devServer: {
    contentBase: __dirname,
    watchContentBase: true,
    compress: true,
    port: 9000,
    liveReload: false
  }
};