Chekhov.controller "ChecklistCtrl", @ChecklistCtrl = ($scope, $timeout, $routeParams, Checklists, User) ->
  $scope.loaded = false
  $scope.checklist = {}
  $scope.checklist.entries_attributes = []
  $scope.user = User
  $scope.error = null
  delayedSave = null
  
  $('ul.nav li').removeClass 'active'
  
  $scope.togglePublic = () ->
    $scope.checklist.public = (if $scope.checklist.public then false else true)
    $scope.saveChanges()
    
  $scope.check = (entry) ->
    entry.checked = (if entry.checked then false else true)
    $scope.saveChanges()

  $scope.saveAfterDelay = () ->
    $timeout.cancel(delayedSave)
    delayedSave = $timeout (->
      $scope.saveChanges()
    ), 3000
    
  $scope.saveChanges = () ->
    Checklists.update $scope.checklist,
      (data) ->
        # Success
        $scope.checklist = data
        $scope.checklist.entries_attributes = $scope.checklist.entries
    , (data) ->
        # Error
        $scope.error = "Could not save changes!"
  
  $scope.clearError = ->
    $scope.error = null
  
  Checklists.get({id: $routeParams.id},
    (data) ->
      # Success
      $scope.checklist = data
      $scope.checklist.entries_attributes = $scope.checklist.entries
      delete $scope.checklist.entries
      $scope.loaded = true
  , (data) ->
      # Error
      $('div#loading').html("<b>You don't have permission to view this checklist.</b>")
  )
