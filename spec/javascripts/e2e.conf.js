var sharedConfig = require('./shared.conf');

module.exports = function(config) {
  var conf = sharedConfig();

  conf.frameworks = ['ng-scenario'];

  conf.files = conf.files.concat([
    //test files
    'spec/javascripts/e2e/**/*.js'
  ]);

  conf.proxies = {
    '/': 'http://localhost:3000/'
  };

  conf.urlRoot = '/__karma__/';

  config.set(conf);
};
