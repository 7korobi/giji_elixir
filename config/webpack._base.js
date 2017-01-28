var webpack  = require('webpack');
var compress = require("compression-webpack-plugin");
var html = require('html-webpack-plugin');
var copy = require("copy-webpack-plugin");

var path = require("path");
var dir = (str) => {
  return path.resolve(__dirname, "..", str);
};


module.exports = {
  entry: {
    "js/app":    "js/app.js",
    "js/chr":    "js/chr.js",
    "js/socket": "js/socket.js",
    "js/common": "js/common.js",
    "js/rails":  "js/rails.js",
    "js/sow":    "js/sow.js"
  },

  module: {
    loaders: [
      { test:       /\.pug$/, loader: "pug-html", query: {pretty: true } },
      { test:      /\.styl$/, loader: "style!css!stylus?resolve url"},
      { test: /\.styl\.use$/, loader: "style/useable!css!stylus?resolve url"},
      { test:       /\.vue$/, loader: 'vue' },
      { test:        /\.js$/, loader: "babel", exclude: /node_modules/ },
      { test:       /\.yml$/, loader: 'json!yaml' },
      { test:    /\.coffee$/, loader: "coffee" },
      { test: /\.(jpg|png|svg)$/, loader: "file?name=[path][name].[ext]"}
    ]
  },

  vue: {},

  plugins: [
    /*
    new copy([
      { from: "images", to: "images" },
      { from: dir("../../web_work/images/portrate"), to: "images/portrate" }
    ]),
    */
    new html({
      filename: 'html/test.html',
      template: 'html/test.pug',
      chunks: ['js/test']
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name: "js/base",
      filename: "js/base.js",
      minChunks: 2
    }),
    new webpack.optimize.AggressiveMergingPlugin({
      minSizeReduce: 1.5,
      entryChunkMultiplicator: 10,
      moveToParents: true
    })
  ],

  devtool: 'source-map',
  // source-map cheap-source-map
  target: "web",
  // web webworker node async-node node-webkit electron electron-renderer

  context: dir("web/static/"),
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
    jsonpFunction: "gijiP",
    library: false,
    libraryTarget: "var", // var, this, umd
    path: dir('priv/static/'),
    publicPath: "http://s3-ap-northeast-1.amazonaws.com/giji-assets/",
    filename: '[name].js'
  },
  resolve: {
    root: [
      dir('web/static/')
    ],
    modulesDirectories: [
      'node_modules'
    ],
    extensions: ['', '.js', '.coffee'],
    alias: {
      '~vue':    'vue',
      '~js':     'js',
      '~styl':   'styl'
    }
  }
};
