base = require("./webpack._base")

var webpack  = require('webpack');
var compress = require("compression-webpack-plugin");

base.plugins.push(
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
  debug:  true,
  cache:  true,
});
