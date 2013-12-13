Chekhov.controller "TemplatesOpenIndexCtrl", @TemplatesOpenIndexCtrl = ($scope, $routeParams, Templates) ->
  $scope.checklists = Checklists.query()
  
  console.debug 'TemplatesOpenIndexCtrl', 'Initializing...'

  $('ul.nav li#checklists_all').removeClass 'active'
  $('ul.nav li#checklists_open').addClass 'active'
  
  # $scope.startChecklist = (template_id) ->
  #   console.debug template_id