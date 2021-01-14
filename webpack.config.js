const path = require('path');
const webpack = require('webpack');
const {CleanWebpackPlugin} = require('clean-webpack-plugin');

module.exports = {
  entry: path.resolve(__dirname, 'src/index.js'),
  output: {
    publicPath: '',
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'dist')
  },
  mode: 'development',
  // devServer: {
  //   // contentBase: path.resolve(__dirname, 'dist'),
  //   watchContentBase: true,
  //   compress: true,
  //   port: 9000,
  //   liveReload: false
  // },
  plugins: [
    new CleanWebpackPlugin()
  ],
  module: {
    rules: [
      {
        test: /\.(jsx|js)$/,
        exclude: /(node_modules)/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.csd$/,
        use: {
          loader: 'raw-loader'
        }
      }
    ]
  }
};