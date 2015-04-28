Chekhov.controller "ChecklistCtrl", @ChecklistCtrl = ($scope, $rootScope, $timeout, $location, $routeParams, Checklists, User) ->
  $scope.loaded = false
  $scope.checklist = {}
  $scope.checklist.entries_attributes = []
  $scope.checklist.comments_attributes = []
  $scope.user = User
  $scope.error = null
  $scope.saved = null
  $scope.progbar = { style: {width: "0%" }, text: "None completed" }

  $scope.edit = if $location.search().new then true else false

  #$('ul.nav li').removeClass 'active'

  $scope.togglePublic = () ->
    $scope.checklist.public = (if $scope.checklist.public then false else true)
    $scope.saveChanges()

  $scope.check = (entry) ->
    entry.checked = (if entry.checked then false else true)
    # See application.html.erb and services.js.coffee for where user.user_name is set
    entry.completed_by = $scope.user.user_name
    entry.finished = new Date()
    #Save iff it is unchecked or no ticket associated
    $scope.saveChanges() if (!entry.checked || $scope.checklist.ticket_number == null)

  $scope.displayTimeSpent= (entry) ->
    !entry.checked and ($scope.checklist.ticket_number != null)

  # Saves changes iff SysAid number changed
  $scope.setTicketNumber = () ->
    if $scope.current_ticket_id != $scope.checklist.ticket_number
      $scope.saveChanges()

  # Returns the numbers of checked entries and total entries, respectively.
  checkedEntries = -> _.filter($scope.checklist.entries_attributes, (e) -> e.checked).length
  entryCount = -> $scope.checklist.entries_attributes.length

  # Updates the progress bar with the appropriate width and text saying how many
  # items have been completed compared to the total. Displays 0% for the text if
  # nothing's been completed (it's all that fits in 2em).
  updateProgressBar = ->
    $scope.progbar = {
        style:
            width: Math.round((checkedEntries() / entryCount()) * 100) + "%"
        text: (if checkedEntries() isnt 0 then checkedEntries() + " of " + entryCount() + " completed" else "0%")
    }

  $scope.editTitle = () ->
    $scope.edit = true

  $scope.editDescription = () ->
    $scope.editDesc = true

  $scope.saveChanges = (close = "none") ->
    $scope.saved = "Saving ..."

    previouslyFinished = $scope.checklist.finished
    $scope.checklist.comments_attributes.push {content: $scope.newComment} if $scope.newComment

    Checklists.update $scope.checklist,
      (data) ->
        # Success
        $scope.clearError()
        $scope.parseJSON(data)

        $scope.edit = false  if close == "title"
        $scope.editDesc = false  if close == "desc"

        # Clear new comment field
        $scope.newComment = ''

        # Update progress bar
        updateProgressBar()

        # Archive the checklist when all of entries are checked
        if checkedEntries() is entryCount()
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
        $scope.saved = null

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
    updateProgressBar()
    delete $scope.checklist.entries

  $scope.completed = (entry) ->
    if entry.finished
        return "finished"
    else
        return ""

  Checklists.get({id: $routeParams.id},
    (data) ->
      # Success
      $scope.parseJSON(data)
      $scope.loaded = true
  , (data) ->
      # Error
      $('div#loading').html("<b>You don't have permission to view this checklist.</b>")
  )

  $scope.editTitle()  if $scope.edit

  $scope.$watch('edit', (edit) ->
      if edit
        $('#checklist-title').focus()
        $timeout (->
            $('#checklist-title').focus()
        ), 0
  )

  $scope.$watch('editDesc', (edit) ->
      if edit
        $('#desc').focus()
        $timeout (->
            $('#desc').focus()
        ), 0
  )
