Chekhov.controller "TemplateNewCtrl", @TemplateNewCtrl = ($scope, $routeParams, Templates, $location, User) ->
  $scope.newTemplate = {}
  $scope.newTemplate.entries_attributes = []
  $scope.newContent = null
  $scope.position = 1
  
  console.debug 'TemplateNewCtrl', 'Initializing...'
  
  $scope.addToEntries = () ->
    if $scope.newContent
      $scope.newTemplate.entries_attributes.push {content: $scope.newContent, position: $scope.position}
      $scope.position++
    $scope.newContent = ""
  
  $scope.save = () ->
    if $scope.newTemplate.entries_attributes.length and $scope.newTemplate.name
      Templates.save $scope.newTemplate, (data) ->
        $location.path("/")
