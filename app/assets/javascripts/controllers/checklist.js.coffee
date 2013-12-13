Chekhov.controller "ChecklistCtrl", @ChecklistCtrl = ($scope, $routeParams, Checklists) ->
  $scope.checklist = {}
  
  Checklists.get {id: $routeParams.id}, (data) ->
    $scope.checklist = data
