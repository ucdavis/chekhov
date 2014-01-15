Chekhov.controller "ChecklistNavigationCtrl", @ChecklistNavigationCtrl = ($scope, $location, Templates, Checklists, User, navDisplayService) ->
  $scope.loaded = false
  $scope.error = null
  
  # Templates
  $scope.templates = Templates.query {},
    (data) ->
      # Success
      $scope.loaded = true
      navDisplayService.updateTotalTemplate $scope.templates.length
  , (data) ->
      # Error
      $scope.error = "Error retrieving information from server"

  # Checklists
  $scope.checklists = Checklists.query {},
    (data) ->
      # Success
      $scope.loaded = true
      $scope.user = User
      navDisplayService.updateTotalActive $scope.checklists.length
  , (data) ->
      # Error
      $scope.error = "Error retrieving information from server"     
      
  # Archived    
  $scope.archived = Checklists.archived {},
    (data) ->
      # Success
      $scope.loaded = true
      navDisplayService.updateTotalArchived $scope.archived.length
  , (data) ->
      # Error
      $scope.error = "Error retrieving information from server"
