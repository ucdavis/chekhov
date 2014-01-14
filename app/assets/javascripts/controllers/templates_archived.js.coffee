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

  $scope.allArchived = $scope.checklists
  
  console.debug 'TemplatesArchivedIndexCtrl', 'Initializing...'

  $('ul.nav li').removeClass 'active'
  $('ul.nav li#checklists_archived').addClass 'active'
  
  $scope.openChecklist = (checklist_id) ->
    $location.path("/checklists/#{checklist_id}")

  $scope.clearError = ->
    $scope.error = null

  $scope.$watch "search", (value) ->
    if value
      $scope.checklists = _.filter($scope.allArchived, (c) ->
          c.name.toLowerCase().indexOf(value) != -1
        )
    else
      $scope.checklists = $scope.allArchived
  , true
