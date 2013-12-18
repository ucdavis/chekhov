Chekhov.controller "TemplateEditCtrl", @TemplateEditCtrl = ($scope, $routeParams, Templates, $location) ->
  $scope.loaded = false
  $scope.template = {}
  $scope.template.entries_attributes = []
  $scope.newContent = null
  $scope.position = 1

  console.debug 'TemplateEditCtrl', 'Initializing...'
  
  $scope.addToEntries = () ->
    if $scope.newContent
      $scope.template.entries_attributes.push {content: $scope.newContent, position: $scope.position}
      $scope.position++
    $scope.newContent = ""

  $scope.removeFromEntries = (entry) ->
    entry._destroy = true
  
  $scope.save = () ->
    if $scope.template.entries_attributes.length and $scope.template.name
      Templates.update $scope.template, (data) ->
        $location.path("/")

  Templates.get {id: $routeParams.id}, (data) ->
    $scope.template = data
    $scope.template.entries_attributes = $scope.template.entries
    delete $scope.template.entries
    $scope.position = _.max(_.pluck($scope.template.entries_attributes, "position")) + 1
    $scope.loaded = true
