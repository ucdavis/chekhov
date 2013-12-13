Chekhov.controller "TemplatesIndexCtrl", @TemplatesIndexCtrl = ($scope, $routeParams, Templates) ->
  $scope.templates = Templates.query()
  $scope.activeTab = 1
  
  console.debug 'TemplatesIndexCtrl', 'Initializing...'

  $('ul.nav li#checklists_open').removeClass 'active'
  $('ul.nav li#checklists_all').addClass 'active'
  
  # <li class="active"><a href="#/">All Checklists</a></li>
  # <li><a href="#/open">Open Checklists</a></li>
  

  $scope.startChecklist = (template_id) ->
    console.debug template_id