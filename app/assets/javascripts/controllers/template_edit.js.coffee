Chekhov.controller "TemplateEditCtrl", @TemplateEditCtrl = ($scope, $timeout, $routeParams, Templates, User, TemplateCategories, $location) ->
  $scope.loaded = false
  $scope.template = {}
  $scope.template.entries_attributes = []
  $scope.categories = TemplateCategories.query {}
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

  $scope.newCategory = (event) ->
    # Don't do anything if typeahead box is open.
    return  if $(event.target).attr('aria-expanded') == true

    $scope.template.template_category = {}
    $scope.template.template_category.name = event.target.value

  $scope.saveCategory = (item) ->
    $scope.template.template_category = item

  $scope.save = () ->
    $scope.addToEntries();
    $scope.notifySave = "Saving..."
    $scope.noTimeout = true

    if not User.is_admin
        $scope.notifySave = "Permission Denied"
        $scope.error = "Permission denied. You must be an Administrator to edit a template."
        return

    if $scope.template.entries_attributes.length and $scope.template.name
      Templates.update $scope.template,
        (data) ->
          $scope.noTimeout = false
          $scope.notifySave = "Saved"
          refreshIds()
          $location.path("/templates/manage")
          
      , (data) ->
          # Error
          $scope.noTimeout = false
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
      # Moving down
      if ui.item.sortable.dropindex > ui.item.sortable.index
        $scope.template.entries_attributes[ui.item.sortable.index].position = ui.item.sortable.dropindex + 0.5
      # Moving up
      else
        $scope.template.entries_attributes[ui.item.sortable.index].position = ui.item.sortable.dropindex - 0.5

      # Re-number to use integers
      $scope.template.entries_attributes =
        _.map(_.zip(_.sortBy($scope.template.entries_attributes, "position"),
                    _.range($scope.template.entries_attributes.length)),
              (entry) ->
                entry[0].position = entry[1]
                entry[0]
        )
  
  refreshIds = ->
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

  refreshIds()
