base = require("./webpack._base")

var webpack  = require('webpack');
var compress = require("compression-webpack-plugin");

base.plugins.push(
  new webpack.optimize.UglifyJsPlugin({
    compress:  true,
    mangle:    true,
    beautify: false,
    comments: false,
    sourceMap: true,
  }),
  new compress({
    asset: "[path].gz[query]",
    algorithm: "gzip",
    test: /\.js$|\.html$/,
    threshold: 1,
    minRatio: 0.8
  })
  new compress({
    asset: "[path].gz[query]",
    algorithm: "gzip",
    test: /\.js$|\.html$/,
    threshold: 1,
    minRatio: 0.8
  })
);

module.exports = Object.assign(base, {
  target: "web",
  debug:  false,
  cache:  false,
});
