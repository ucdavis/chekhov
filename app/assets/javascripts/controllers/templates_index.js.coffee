Chekhov.controller "TemplatesIndexCtrl", @TemplatesIndexCtrl = ($scope, $routeParams, $modal, $location, Templates, Checklists, User) ->
  $scope.loaded = false
  $scope.templates = Templates.query ->
    $scope.loaded = true
    
  $scope.activeTab = 1
  $scope.user = User
  
  console.debug 'TemplatesIndexCtrl', 'Initializing...'

  $('ul.nav li').removeClass 'active'
  $('ul.nav li#checklists_all').addClass 'active'

  $scope.startChecklist = (template_id) ->
    modalInstance = $modal.open
      templateUrl: "/assets/partials/checklist_new.html"
      controller: ChecklistNewCtrl

    modalInstance.result.then (checklist) ->
      Checklists.save {template_id: template_id, name: checklist.name, public: checklist.public, user_id: User.id}, (data) ->
        $location.path("/checklists/#{data.id}")

  $scope.deleteTemplate = (template_id) ->
    modalInstance = $modal.open
      templateUrl: "/assets/partials/template_delete.html"
      controller: TemplateDeleteCtrl

    modalInstance.result.then () ->
      Templates.delete {id: template_id}, (data) ->
        $location.path("/active")
