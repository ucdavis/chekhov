module.exports = function() {
  return {
    basePath: '../../',
    frameworks: ['mocha'],
    reporters: ['progress'],
    browsers: ['Chrome'],
    autoWatch: true,
    preprocessors: { 
      '**/*.coffee': 'coffee' 
    },  

    // these are default values anyway
    singleRun: false,
    colors: true,
    
    files: [ 
      //3rd Party Code
      'vendor/assets/javascripts/jquery.js', 
      'vendor/assets/javascripts/angular.js', 
      'vendor/assets/javascripts/angular-route.js', 
      'vendor/assets/javascripts/angular-resource.js', 
      'vendor/assets/javascripts/ui-bootstrap.js', 
      'vendor/assets/javascripts/sortable.js', 
      
      //App-specific Code
      'app/assets/javascripts/router.js.coffee', 
      'app/assets/javascripts/chekhov.js.coffee', 
      'app/assets/javascripts/services.js.coffee', 
      'app/assets/javascripts/controllers/*', 
      'app/assets/javascripts/directives/*',

      //Test-Specific Code
      'spec/javascripts/lib/chai.js',
      'spec/javascripts/lib/chai-should.js',
      'spec/javascripts/lib/chai-expect.js'
    ]   
  }
};
