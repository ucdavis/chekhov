var sharedConfig = require('./shared.conf');

module.exports = function(config) {
  var conf = sharedConfig();

  conf.files = conf.files.concat([
    //extra testing code
    'spec/javascripts/lib/ngMidwayTester.js',

    //test files
    'spec/javascripts/midway/**/*.js'
  ]);

  conf.proxies = {
    '/': 'http://localhost:3000/'
  };

  conf.urlRoot = '/__karma__/';

  config.set(conf);
};
