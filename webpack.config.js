const webpack  = require('webpack');
const compress = require("compression-webpack-plugin");
const html = require('html-webpack-plugin');
const copy = require("copy-webpack-plugin");

const path = require("path");

const dir = function(str) {
  let ary = str.split("/");
  ary.unshift(__dirname);
  return path.join.apply(path, ary);
};


module.exports = {
  watch: false,
  progress: true,
  keepalive: false,
  failOnError: false,
  stats: {
    colors:  true,
    modules: true,
    reasons: true
  },

  devtool: 'source-map',

  context: dir("web/static"),
  entry: {
    "js/base":   "js/base.js",
    "js/app":    "js/app.js",
    "js/chr":    "js/chr.js",
    "js/socket": "js/socket.js",
    "js/test":   "js/test.coffee"
  },
  output: {
    pathinfo: true,
    jsonpFunction: "giji",
    libraryTarget: "window",
    path: dir('/priv/static'),
    filename: '[name].js'
  },

  resolve: {
    root: [
      dir('/web/static')
    ],
    modulesDirectories: [
      'node_modules'
    ],
    extensions: ['', '.js', '.coffee']
  },

  module: {
    loaders: [
      { test:         /\.pug$/, loader: "pug", query: {pretty: true } },
      { test:         /\.yml$/, loader: 'json!yaml' },
      { test:          /\.js$/, loader: "babel", exclude: /node_modules/ },
      { test:      /\.coffee$/, loader: "coffee" }
    ]
  },

  plugins: [
    new copy([
      { from: "assets", to: "assets" }
    ]),
    new html({
      filename: 'html/index.html'
    }),
    new html({
      filename: 'html/test.html',
      template: 'html/test.pug',
      chunks: ['js/test']
    }),


    // new webpack.optimize.UglifyJsPlugin(),
    new webpack.optimize.CommonsChunkPlugin('js/base','js/base.js'),
    new compress({
      asset: "[path].gz[query]",
      algorithm: "gzip",
      test: /\.js$|\.html$/,
      threshold: 1,
      minRatio: 0.8
    })
  ]
};
