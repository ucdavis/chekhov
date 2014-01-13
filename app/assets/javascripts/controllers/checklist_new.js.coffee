Chekhov.controller "ChecklistNewCtrl", @ChecklistNewCtrl = ($scope, $modalInstance) ->
  $scope.newChecklist = {public: true}

  $scope.create = ->
    $modalInstance.close $scope.newChecklist

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
