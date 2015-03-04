Chekhov.controller "TemplateNewCtrl", @TemplateNewCtrl = ($scope, Templates, User, $location, $rootScope) ->
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
  
  $scope.removeFromEntries = (position) ->
    entry = _.findWhere($scope.newTemplate.entries_attributes, {position: position})
    index = $scope.newTemplate.entries_attributes.indexOf(entry)
    $scope.newTemplate.entries_attributes.splice(index,1)
  
  $scope.setEditingEntry = (position) ->
    $scope.editingEntry = position

  $scope.unsetEditingEntry = () ->
    $scope.editingEntry = null

  $scope.save = () ->
    $scope.notifySave = "Saving..."
    $scope.noTimeout = true
    if not User.is_admin
        $scope.notifySave = "Permission Denied"
        $scope.error = "Permission denied. You must be an Administrator to create a template."
        return

    if $scope.newTemplate.entries_attributes.length and $scope.newTemplate.name
      Templates.save $scope.newTemplate,
        (data) ->
          # Success
          $location.path("/templates/manage")
          $rootScope.template_count++
      , (data) ->
          # Error
          $scope.noTimeout = false
          $scope.notifySave = "Could not save changes"
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
    axis: 'y'
    update: (e, ui, a, b) ->
      $scope.newTemplate.entries_attributes[ui.item.sortable.index].position = ui.item.sortable.dropindex
      $scope.newTemplate.entries_attributes[ui.item.sortable.dropindex].position = ui.item.sortable.index
