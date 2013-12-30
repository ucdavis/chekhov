var sharedConfig = require('./shared.conf');

module.exports = function(config) {
  var conf = sharedConfig();

  conf.files = conf.files.concat([
    //extra testing code
    'spec/javascripts/lib/angular-mocks.js',

    //test files
    'spec/javascripts/unit/**/*.js'
  ]);

  config.set(conf);
};
