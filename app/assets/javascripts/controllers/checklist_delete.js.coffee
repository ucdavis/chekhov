Chekhov.controller "ChecklistDeleteCtrl", @ChecklistDeleteCtrl = ($scope, $modalInstance) ->

  $scope.confirm = ->
    $modalInstance.close "delete"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
