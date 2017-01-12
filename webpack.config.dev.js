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
    "js/socket": "js/socket.js",
    "js/sow":    "js/sow.js"
  },

  module: {
    loaders: [
      { test:      /\.pug$/, loader: "pug-html", query: {pretty: true } },
      { test: /\.s[a|c]ss$/, loader: "style!css!sass" },
      { test:      /\.vue$/, loader: 'vue' },
      { test:       /\.js$/, loader: "babel", exclude: /node_modules/ },
      { test:      /\.yml$/, loader: 'json!yaml' },
      { test:   /\.coffee$/, loader: "coffee" }
    ]
  },

  vue: {
    loaders: {
      html: 'pug',
      scss: 'style!css!sass'
    }
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
    new webpack.optimize.CommonsChunkPlugin('js/base','js/base.js'),
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
