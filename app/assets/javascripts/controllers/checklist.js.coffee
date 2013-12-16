Chekhov.controller "ChecklistCtrl", @ChecklistCtrl = ($scope, $routeParams, Checklists, User) ->
  $scope.checklist = {}
  $scope.checklist.entries_attributes = []
  $scope.user = User
  
  $('ul.nav li').removeClass 'active'
  
  $scope.togglePublic = () ->
    $scope.checklist.public = (if $scope.checklist.public then false else true)
    $scope.saveChanges()
    
  $scope.check = (entry) ->
    entry.checked = (if entry.checked then false else true)
    $scope.saveChanges()

  $scope.saveChanges = () ->
    Checklists.update $scope.checklist, (data) ->
      console.log 'saved?'
      console.log data
  
  Checklists.get {id: $routeParams.id}, (data) ->
    $scope.checklist = data
    $scope.checklist.entries_attributes = $scope.checklist.entries
    delete $scope.checklist.entries
