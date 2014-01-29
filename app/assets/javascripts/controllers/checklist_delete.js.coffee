Chekhov.controller "ChecklistDeleteCtrl", @ChecklistDeleteCtrl = ($scope, $modalInstance, checklist) ->

  $scope.checklist = checklist
  $scope.confirm = ->
    $modalInstance.close "delete"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
