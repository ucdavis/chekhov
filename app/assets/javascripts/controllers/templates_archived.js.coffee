Chekhov.controller "TemplatesArchivedIndexCtrl", @TemplatesArchivedIndexCtrl = ($scope, $location, Checklists) ->
  $scope.loaded = false
  $scope.error = null
  $scope.checklists = Checklists.archived {},
    (data) ->
      # Success
      $scope.loaded = true
  , (data) ->
      # Error
      $scope.error = "Error retrieving information from server"
  
  
  console.debug 'TemplatesArchivedIndexCtrl', 'Initializing...'

  $('ul.nav li').removeClass 'active'
  $('ul.nav li#checklists_archived').addClass 'active'
  
  $scope.openChecklist = (checklist_id) ->
    $location.path("/checklists/#{checklist_id}")

  $scope.clearError = ->
    $scope.error = null
