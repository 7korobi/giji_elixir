var webpack  = require('webpack');
var compress = require("compression-webpack-plugin");
var html = require('html-webpack-plugin');
var copy = require("copy-webpack-plugin");

var path = require("path");
var dir = function(str) {
  var ary = str.split("/");
  ary.unshift(__dirname);
  return path.join.apply(path, ary);
};


module.exports = {
  entry: {
    "js/base":   "js/base.js",
    "js/app":    "js/app.js",
    "js/chr":    "js/chr.js",
    "js/socket": "js/socket.js"
  },

  module: {
    loaders: [
      { test:    /\.pug$/, loader: "pug", query: {pretty: true } },
      { test:     /\.js$/, loader: "babel", exclude: /node_modules/ },
      { test:    /\.yml$/, loader: 'json!yaml' },
      { test: /\.coffee$/, loader: "coffee" }
    ]
  },

  plugins: [
    new copy([
      { from: "assets", to: "assets" },
      { from: dir("../../web_work/images/portrate"), to: "assets/images/portrate" }
    ]),
    new html({
      filename: 'html/index.html'
    }),
    new html({
      filename: 'html/test.html',
      template: 'html/test.pug',
      chunks: ['js/test']
    }),
    new webpack.optimize.AggressiveMergingPlugin({
      minSizeReduce: 1.5,
      entryChunkMultiplicator: 10,
      moveToParents: true
    }),
    new webpack.optimize.UglifyJsPlugin({
      compress: true,
      mangle: true,
      beautify: false,
      comments: false,
      sourceMap: true,
    }),
    new webpack.optimize.CommonsChunkPlugin('js/base','js/base.js'),
    new compress({
      asset: "[path].gz[query]",
      algorithm: "gzip",
      test: /\.js$|\.html$/,
      threshold: 1,
      minRatio: 0.8
    })
  ],

  devtool: 'source-map',
  // source-map cheap-source-map
  target: "web",
  // web webworker node async-node node-webkit electron electron-renderer

  context: dir("web/static"),
  progress: true,
  profile: true,
  debug: true,
  cache: false,
  stats: {
    colors:  true,
    modules: true,
    reasons: true
  },
  output: {
    pathinfo: true,
    jsonpFunction: "giji",
    library: false,
    libraryTarget: "var", // var, this, umd
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
  }
};
