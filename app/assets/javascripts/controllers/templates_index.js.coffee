Chekhov.controller "TemplatesIndexCtrl", @TemplatesIndexCtrl = ($scope, $routeParams, Templates) ->
  $scope.templates = Templates.query()
