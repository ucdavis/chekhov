Chekhov.controller "TemplateNewCtrl", @TemplateNewCtrl = ($scope, $routeParams, Templates, $location, User) ->
  $scope.newTemplate = {}
  $scope.newTemplate.entries_attributes = []
  $scope.newContent = null
  $scope.position = 1
  
  $scope.addToEntries = () ->
    if $scope.newContent
      $scope.newTemplate.entries_attributes.push {content: $scope.newContent, position: $scope.position}
      $scope.position++
    $scope.newContent = ""
  
  $scope.save = () ->
    $scope.newTemplate.owner_id = User.id
    Templates.save $scope.newTemplate, (data) ->
      $location.path("/")
      # $scope.newTemplate = {}
      # $scope.newTemplate.entries_attributes = []
      # $scope.newContent = null
      # $scope.position = 1
      