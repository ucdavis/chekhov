Chekhov.controller "ChecklistNavigationCtrl", @ChecklistNavigationCtrl = ($scope, $location, Templates, Checklists, User, $rootScope) ->
  $scope.loaded = false
  $scope.error = null

  # Templates
  $rootScope.template_count = window.template_count
  
  # Checklists
  $rootScope.active_count = window.active_count
  
  # Archived    
  $rootScope.archived_count = window.archived_count
