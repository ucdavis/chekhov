Chekhov.controller "TemplateDuplicateCtrl", @TemplateDuplicateCtrl = ($scope, $routeParams, Templates, $location, $rootScope) ->
  $scope.loaded = false
  $scope.newTemplate = {}
  $scope.newTemplate.entries_attributes = []
  $scope.newContent = null
  $scope.position = 0
  $scope.error = null
  
  console.debug 'TemplateDuplicateCtrl', 'Initializing...'
  
  $scope.addToEntries = () ->
    if $scope.newContent
      $scope.newTemplate.entries_attributes.push {content: $scope.newContent, position: $scope.position}
      $scope.position++
    $scope.newContent = ""
  
  $scope.removeFromEntries = (position) ->
    entry = _.findWhere($scope.newTemplate.entries_attributes, {position: position})
    index = $scope.newTemplate.entries_attributes.indexOf(entry)
    $scope.newTemplate.entries_attributes.splice(index,1)
  
  $scope.save = () ->
    if $scope.newTemplate.entries_attributes.length and $scope.newTemplate.name
      Templates.save $scope.newTemplate,
        (data) ->
          # Success
          $location.path("/")
          $rootScope.template_count++
      , (data) ->
          # Error
          $scope.error = "Could not save changes"
          _.each(data.data.errors , (e,i) ->
              $scope.error = $scope.error + "<li>#{i} #{e}</li>"
            )
    else if !$scope.newTemplate.name
      $scope.error = "Please provide a name"
    else if $scope.newTemplate.entries_attributes.length == 0
      $scope.error = "Please provide at least one checklist item"

  $scope.clearError = ->
    $scope.error = null

  $scope.sortableOptions =
    handle: '.handle'
    axis: 'y'
    update: (e, ui, a, b) ->
      $scope.newTemplate.entries_attributes[ui.item.sortable.index].position = ui.item.sortable.dropindex
      $scope.newTemplate.entries_attributes[ui.item.sortable.dropindex].position = ui.item.sortable.index

  Templates.get {id: $routeParams.id},
    (data) ->
      # Success
      $scope.newTemplate.name = data.name
      $scope.newTemplate.entries_attributes = _.map(data.entries, (entry) ->
          {content: entry.content, position: $scope.position++}
        )
      $scope.loaded = true
  , (data) ->
      # Error
      $scope.error = "Error retrieving information from server"
