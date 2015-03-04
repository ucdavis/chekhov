Chekhov.controller "TemplateEditCtrl", @TemplateEditCtrl = ($scope, $timeout, $routeParams, Templates, User, $location) ->
  $scope.loaded = false
  $scope.template = {}
  $scope.template.entries_attributes = []
  $scope.newContent = null
  $scope.position = 0
  $scope.error = null
  $scope.saved = null
  $scope.notifySave = null

  console.debug 'TemplateEditCtrl', 'Initializing...'
  
  $scope.addToEntries = () ->
    if $scope.newContent
      $scope.template.entries_attributes.push {content: $scope.newContent, position: $scope.position}
      $scope.position++
    $scope.newContent = ""

  $scope.removeFromEntries = (position) ->
    entry = _.findWhere($scope.template.entries_attributes, {position: position})
    entry._destroy = true
  
  $scope.setEditingEntry = (position) ->
    $scope.editingEntry = position

  $scope.unsetEditingEntry = () ->
    $scope.editingEntry = null

  $scope.save = () ->
    $scope.notifySave = "Saving..."
    if not User.is_admin
        $scope.notifySave = "Permission Denied"
        $scope.error = "Permission denied. You must be an Administrator to edit a template."
        return

    if $scope.template.entries_attributes.length and $scope.template.name
      Templates.update $scope.template,
        (data) ->
          $scope.notifySave = "Saved"
      , (data) ->
          # Error
          $scope.notifySave = "Could not save changes"
          $scope.error = "Could not save changes"
          _.each(data.data.errors , (e,i) ->
              $scope.error = $scope.error + "<li>#{i} #{e}</li>"
            )
    else if !$scope.template.name
      $scope.error = "Please provide a name"
    else if $scope.template.entries_attributes.length == 0
      $scope.error = "Please provide at least one checklist item"

  $scope.clearError = ->
    $scope.error = null
  
  $scope.sortableOptions =
    axis: 'y'
    update: (e, ui, a, b) ->
      $scope.template.entries_attributes[ui.item.sortable.index].position = ui.item.sortable.dropindex
      $scope.template.entries_attributes[ui.item.sortable.dropindex].position = ui.item.sortable.index

  Templates.get {id: $routeParams.id},
    (data) ->
      # Success
      $scope.template = data
      $scope.template.entries_attributes = $scope.template.entries
      delete $scope.template.entries
      $scope.position = _.max(_.pluck($scope.template.entries_attributes, "position")) + 1
      $scope.loaded = true
  , (data) ->
      # Error
      $scope.error = "Error retrieving information from server"
