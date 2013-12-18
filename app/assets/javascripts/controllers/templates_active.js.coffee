Chekhov.controller "TemplatesActiveIndexCtrl", @TemplatesActiveIndexCtrl = ($scope, $routeParams, $location, Checklists) ->
  $scope.loaded = false
  $scope.checklists = Checklists.query ->
    $scope.loaded = true
  
  console.debug 'TemplatesActiveIndexCtrl', 'Initializing...'

  $('ul.nav li').removeClass 'active'
  $('ul.nav li#checklists_active').addClass 'active'
  
  $scope.openChecklist = (checklist_id) ->
    $location.path("/checklists/#{checklist_id}")
    
  $scope.deleteChecklist = (checklist_id) ->
    modalInstance = $modal.open
      templateUrl: "/assets/partials/checklist_delete.html"
      controller: ChecklistDeleteCtrl

    modalInstance.result.then () ->
      Checklists.delete {id: checklist_id}, (data) ->
        $location.path("/active")
