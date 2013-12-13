Chekhov.controller "TemplateNewCtrl", @TemplateNewCtrl = ($scope, $routeParams, Templates) ->
  $scope.newTemplate = {}
  $scope.newTemplate.entries_attributes = []
  $scope.newContent = null
  
  $scope.addToEntries = () ->
    $scope.newTemplate.entries_attributes.push {content: $scope.newContent, position: 1} if $scope.newContent
    $scope.newContent = ""
  
  $scope.save = () ->
    $scope.newTemplate.owner_id = 1
    Templates.save $scope.newTemplate, (data) ->
      $scope.newTemplate = []