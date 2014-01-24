Chekhov.controller "ChecklistCtrl", @ChecklistCtrl = ($scope, $rootScope, $timeout, $routeParams, Checklists, User) ->
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

  $scope.saveChanges = () ->
    previouslyFinished = $scope.checklist.finished
    $scope.checklist.comments_attributes.push {content: $scope.newComment} if $scope.newComment

    Checklists.update $scope.checklist,
      (data) ->
        # Success
        $scope.clearError()
        $scope.checklist = data
        $scope.checklist.entries_attributes = $scope.checklist.entries

        # Clear new comment field
        $scope.newComment = ''

        # Check if all entries are checked
        checkedEntries = _.filter($scope.checklist.entries, (e) -> e.checked).length
        allEntries = $scope.checklist.entries.length
        if checkedEntries is allEntries
          $scope.saved = "Saved and archived"
          unless previouslyFinished
            $rootScope.active_count--
            $rootScope.archived_count++
        else
          $scope.saved = "Saved"
          if previouslyFinished 
            $rootScope.active_count++
            $rootScope.archived_count--
        $timeout.cancel(displayStatus)
        displayStatus = $timeout (->
          $scope.saved = null
        ), 3000
    , (data) ->
        # Error
        $scope.error = "Could not save changes"
        # Display errors
        _.each(data.data.errors , (e,i) ->
            $scope.error = $scope.error + "<li>#{i}: #{e}</li>"
            if i is 'SysAid'
              $scope.SysAidError = e[0]
              $('#newCommentGroup').addClass('error')
              # Remove unsaved comments from checklist model
              $scope.checklist.comments_attributes = _.filter($scope.checklist.comments_attributes, (c) -> c.id)
          )

  $scope.clearError = ->
    $scope.error = null
    $scope.SysAidError = null
    $('#newCommentGroup').removeClass('error')
  
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
