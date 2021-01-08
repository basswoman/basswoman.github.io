var path = require('path');

module.exports = {
  entry: path.resolve(__dirname, 'src/index.js'),
  mode: 'none',
  devServer: {
    contentBase: __dirname,
    watchContentBase: true,
    compress: true,
    port: 9000,
    liveReload: false
  }
};