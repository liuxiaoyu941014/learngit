var utils = require('./webpack.utils')
var config = {
  resolve: {
    extensions: ['', '.js', '.coffee', '.vue', '.json', '.css', '.scss', '.sass'],
    alias: {
      vue: 'vue/dist/vue'
    }
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        loader: 'babel',
        exclude: /node_modules/
      },
      { test: /\.vue$/, loader: 'vue' },
      { test: require.resolve('vue/dist/vue'), loader: 'expose?Vue'},
      { test: require.resolve('vuex'), loader: 'expose?Vuex'},
      {
        test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
        loader: 'url',
        query: {
          limit: 10000,
          name: utils.assetsPath('[name].[hash:7].[ext]')
        }
      },
      { test: /\.coffee$/, loader: "coffee-loader" },
      { test: /\.(scss|sass)$/, loader: "style!css!sass" },
    ]
  },
  vue: {
    postcss: [
      require('autoprefixer')({
        browsers: ['last 2 versions']
      })
    ]
  }
}

module.exports = config;
