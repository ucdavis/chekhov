Chekhov.controller "TemplateDeleteCtrl", @TemplateDeleteCtrl = ($scope, $modalInstance, template) ->

  $scope.template = template
  $scope.confirm = ->
    $modalInstance.close "delete"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
