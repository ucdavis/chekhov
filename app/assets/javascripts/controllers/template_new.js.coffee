Chekhov.controller "TemplateNewCtrl", @TemplateNewCtrl = ($scope, $routeParams, Templates) ->
  $scope.newTemplate = {}
  # $scope.newTemplate.entries = []
  $scope.newContent = null
  
  template = Templates.query()
  console.log template
  
  $scope.addToEntries = () ->
    $scope.newTemplate.entries.push {content: $scope.newContent}
    $scope.newContent = ""
  
  $scope.save = () ->
    $scope.newTemplate.owner_id = 1
    Templates.save $scope.newTemplate, (data) ->
      console.log "success"