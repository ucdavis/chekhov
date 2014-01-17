Chekhov.controller "ChecklistCtrl", @ChecklistCtrl = ($scope, $timeout, $routeParams, Checklists, User, navDisplayService) ->
  $scope.loaded = false
  $scope.checklist = {}
  $scope.checklist.entries_attributes = []
  $scope.checklist.comments_attributes = []
  $scope.user = User
  $scope.error = null
  $scope.saved = null
  
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
    previouslyFinished = $scope.checklist.finished
    $scope.checklist.comments_attributes.push {content: $scope.newComment} if $scope.newComment

    Checklists.update $scope.checklist,
      (data) ->
        # Success
        $scope.checklist = data
        $scope.checklist.entries_attributes = $scope.checklist.entries

        # check if all entries are checked
        checkedEntries = _.filter($scope.checklist.entries, (e) -> e.checked).length
        allEntries = $scope.checklist.entries.length
        if checkedEntries is allEntries
          $scope.saved = "Saved Successfully and archived!"
          navDisplayService.decrementActiveTotal "dec"
          navDisplayService.incrementArchivedTotal "inc"
        else
          $scope.saved = "Saved Successfully!"
          if (checkedEntries + 1) is allEntries && previouslyFinished 
            navDisplayService.incrementActiveTotal "inc"
            navDisplayService.decrementArchivedTotal "dec"
        $timeout.cancel(displayStatus)
        displayStatus = $timeout (->
          $scope.saved = null
        ), 3000
    , (data) ->
        # Error
        $scope.error = "Could not save changes"
        _.each(data.data.errors , (e,i) ->
            $scope.error = $scope.error + "<li>#{i} #{e}</li>"
          )
  
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
