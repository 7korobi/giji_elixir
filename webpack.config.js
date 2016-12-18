const webpack = require('webpack');
const compress = require("compression-webpack-plugin")

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

  context: __dirname + "/web/static/js",
  entry: {
    base:   "base.js",
    app:    "app.js",
    chr:    "chr.js",
    socket: "socket.js",
    test:   "test.coffee"
  },
  output: {
    pathinfo: true,
    jsonpFunction: "giji",
    libraryTarget: "window",
    path: __dirname + '/priv/static/js',
    filename: '[name].js'
  },

  resolve: {
    root: [
      __dirname + '/web/static/js'
    ],
    modulesDirectories: [
      'node_modules'
    ],
    extensions: ['', '.js', '.coffee']
  },

  module: {
    loaders: [{
      exclude: /node_modules/,
      test: /\.js$/,
      query: {
          comments: false,
          compact: true
      },
      loader: "babel"
    }, {
      exclude: /node_modules/,
      test: /_spec\.coffee$/,
      loader: "mocha"
    }, {
      exclude: /node_modules/,
      test: /\.coffee$/,
      loader: "coffee"
    }, {
      exclude: /node_modules/,
      test: /\.yml$/,
      loader: 'json!yaml'
    }, {
      exclude: /node_modules/,
      test: /\.pug$/,
      loader: 'file?name=[name].html!pug-html?exports=false'
    }]
  },

  plugins: [
    // new webpack.optimize.UglifyJsPlugin(),
    new webpack.optimize.CommonsChunkPlugin('base','base.js'),
    new compress({
      asset: "[path].gz[query]",
      algorithm: "gzip",
      test: /\.js$|\.html$/,
      threshold: 1,
      minRatio: 0.8
    })
  ]
};

// http://blog.mismithportfolio.com/web/20161130webpackcss