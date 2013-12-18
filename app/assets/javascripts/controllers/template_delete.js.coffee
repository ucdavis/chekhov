Chekhov.controller "TemplateDeleteCtrl", @TemplateDeleteCtrl = ($scope, $modalInstance) ->

  $scope.confirm = ->
    $modalInstance.close "delete"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
