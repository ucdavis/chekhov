Chekhov.controller "TemplatesOpenIndexCtrl", @TemplatesOpenIndexCtrl = ($scope, $routeParams, $location, Checklists) ->
  $scope.checklists = Checklists.query()
  
  console.debug 'TemplatesOpenIndexCtrl', 'Initializing...'

  $('ul.nav li#checklists_all').removeClass 'active'
  $('ul.nav li#checklists_open').addClass 'active'
  
  $scope.openChecklist = (checklist_id) ->
    $location.path("/checklists/#{checklist_id}")