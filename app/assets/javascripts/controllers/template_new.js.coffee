Chekhov.controller "TemplateNewCtrl", @TemplateNewCtrl = ($scope, Templates, $location, $rootScope) ->
  $scope.newTemplate = {}
  $scope.newTemplate.entries_attributes = []
  $scope.newContent = null
  $scope.position = 0
  $scope.error = null
  
  console.debug 'TemplateNewCtrl', 'Initializing...'
  
  $scope.addToEntries = () ->
    if $scope.newContent
      $scope.newTemplate.entries_attributes.push {content: $scope.newContent, position: $scope.position}
      $scope.position++
    $scope.newContent = ""
  
  $scope.removeFromEntries = (entry) ->
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

  $scope.clearError = ->
    $scope.error = null

  $scope.sortableOptions =
    update: (e, ui, a, b) ->
      $scope.newTemplate.entries_attributes[ui.item.sortable.index].position = ui.item.sortable.dropindex
      $scope.newTemplate.entries_attributes[ui.item.sortable.dropindex].position = ui.item.sortable.index
