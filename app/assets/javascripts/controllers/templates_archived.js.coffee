Chekhov.controller "TemplatesArchivedIndexCtrl", @TemplatesArchivedIndexCtrl = ($scope, $location, Checklists) ->
  $scope.loaded = false
  $scope.checklists = Checklists.archived ->
    $scope.loaded = true
  
  
  console.debug 'TemplatesArchivedIndexCtrl', 'Initializing...'

  $('ul.nav li').removeClass 'active'
  $('ul.nav li#checklists_archived').addClass 'active'
  
  $scope.openChecklist = (checklist_id) ->
    $location.path("/checklists/#{checklist_id}")