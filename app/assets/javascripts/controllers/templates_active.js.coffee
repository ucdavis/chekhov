Chekhov.controller "TemplatesActiveIndexCtrl", @TemplatesActiveIndexCtrl = ($scope, $modal, $location, Checklists, User, navDisplayService) ->
  $scope.loaded = false
  $scope.error = null
  $scope.checklists = Checklists.query {},
    (data) ->
      # Success
      $scope.loaded = true
      $scope.user = User
      navDisplayService.updateTotalActive $scope.checklists.length

  , (data) ->
      # Error
      $scope.error = "Error retrieving information from server"

  $scope.allActive = $scope.checklists

  console.debug 'TemplatesActiveIndexCtrl', 'Initializing...'

  $('ul.nav li').removeClass 'active'
  $('ul.nav li#checklists_active').addClass 'active'
  
  $scope.openChecklist = (checklist_id) ->
    $location.path("/checklists/#{checklist_id}")
    
  $scope.deleteChecklist = (checklist) ->
    modalInstance = $modal.open
      templateUrl: "/assets/partials/checklist_delete.html"
      controller: ChecklistDeleteCtrl

    modalInstance.result.then () ->
      Checklists.delete {id: checklist.id},
        (data) ->
          # Success
          index = $scope.checklists.indexOf(checklist)
          $scope.checklists.splice(index,1)
          navDisplayService.updateTotalActive $scope.checklists.length
      , (data) ->
          # Error
          $scope.error = "Error deleting checklist '#{checklist.name}'"

  $scope.clearError = ->
    $scope.error = null

  $scope.$watch "search", (value) ->
    if value
      $scope.checklists = _.filter($scope.allActive, (c) ->
          name = c.name.toLowerCase()
          ticket = c.ticket_number || ""
          name.indexOf(value.toLowerCase()) != -1 || ticket.toString().indexOf(value.toLowerCase()) != -1
        )
    else
      $scope.checklists = $scope.allActive
  , true
