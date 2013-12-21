module.exports = function(config) { 
  config.set({ 
    basePath: '../..', 
 
    frameworks: ['jasmine'], 
 
    autoWatch: true, 
 
    preprocessors: { 
      '**/*.coffee': 'coffee' 
    },  
 
    files: [ 
      'vendor/assets/javascripts/jquery.js', 
      'vendor/assets/javascripts/angular.js', 
      'vendor/assets/javascripts/angular-route.js', 
      'vendor/assets/javascripts/angular-resource.js', 
      'vendor/assets/javascripts/ui-bootstrap.js', 
      'vendor/assets/javascripts/sortable.js', 
      'spec/javascripts/angular-mocks.js', 
      'app/assets/javascripts/router.js.coffee', 
      'app/assets/javascripts/chekhov.js.coffee', 
      'app/assets/javascripts/services.js.coffee', 
      'app/assets/javascripts/controllers/*', 
      'app/assets/javascripts/directives/*', 
      'spec/javascripts/*_spec.js.coffee' 
    ]   
  }); 
}; 