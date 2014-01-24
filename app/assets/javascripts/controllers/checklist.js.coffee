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
    
  # Saves changes iff SysAid number changed
  $scope.setTicketNumber = () ->
    if $scope.current_ticket_id != $scope.checklist.ticket_number
      $scope.saveChanges()

  $scope.saveChanges = () ->
    $scope.saved = "Saving ..."
    
    previouslyFinished = $scope.checklist.finished
    $scope.checklist.comments_attributes.push {content: $scope.newComment} if $scope.newComment

    Checklists.update $scope.checklist,
      (data) ->
        # Success
        $scope.clearError()
        $scope.parseJSON(data)
        
        # Clear new comment field
        $scope.newComment = ''

        # Check if all entries are checked
        checkedEntries = _.filter($scope.checklist.entries_attributes, (e) -> e.checked).length

        entryCount = $scope.checklist.entries_attributes.length

        if checkedEntries is entryCount
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
  
  $scope.parseJSON = (data) ->
    $scope.checklist = data
    $scope.current_ticket_id = data.ticket_number
    $scope.checklist.entries_attributes = $scope.checklist.entries
    delete $scope.checklist.entries
  
  Checklists.get({id: $routeParams.id},
    (data) ->
      # Success
      $scope.parseJSON(data)
      $scope.loaded = true
  , (data) ->
      # Error
      $('div#loading').html("<b>You don't have permission to view this checklist.</b>")
  )
