Chekhov.controller "ChecklistCtrl", @ChecklistCtrl = ($scope, $routeParams, Checklists, User) ->
  $scope.checklist = {}
  
  $scope.togglePublic = () ->
    $scope.checklist.public = (if $scope.checklist.public then false else true)
    
  $scope.check = (entry) ->
    console.log entry
  
  Checklists.get {id: $routeParams.id}, (data) ->
    $scope.checklist = data
