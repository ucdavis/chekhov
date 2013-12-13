Chekhov.controller "TemplatesIndexCtrl", @TemplatesIndexCtrl = ($scope, $routeParams, $modal, $location, Templates, Checklists, User) ->
  $scope.templates = Templates.query()
  $scope.activeTab = 1
  
  console.debug 'TemplatesIndexCtrl', 'Initializing...'

  $('ul.nav li#checklists_open').removeClass 'active'
  $('ul.nav li#checklists_all').addClass 'active'
  
  # <li class="active"><a href="#/">All Checklists</a></li>
  # <li><a href="#/open">Open Checklists</a></li>
  

  $scope.startChecklist = (template_id) ->
    modalInstance = $modal.open
      templateUrl: "/assets/partials/checklist_new.html"
      controller: ChecklistNewCtrl

    modalInstance.result.then (checklist) ->
      Checklists.save {template_id: template_id, name: checklist.name, public: checklist.public, user_id: User.id}, (data) ->
        $location.path("/checklists/#{data.id}")