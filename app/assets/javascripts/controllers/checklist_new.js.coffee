Chekhov.controller "ChecklistNewCtrl", @ChecklistNewCtrl = ($scope, $modalInstance) ->
  $scope.newChecklist = {public: false}

  $scope.create = ->
    $modalInstance.close $scope.newChecklist

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"