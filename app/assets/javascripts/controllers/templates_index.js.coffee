Chekhov.controller "TemplatesIndexCtrl", @TemplatesIndexCtrl = ($scope, $modal, $location, Templates, Checklists, User, $rootScope) ->
  $scope.loaded = false
  $scope.error = null
  $scope.templates = Templates.query {},
    (data) ->
      # Success
      $scope.loaded = true
      $rootScope.template_active = $scope.templates.length
  , (data) ->
      # Error
      $scope.error = "Error retrieving information from server"

  $scope.allTemplates = $scope.templates
    
  $scope.activeTab = 1
  $scope.user = User
  
  console.debug 'TemplatesIndexCtrl', 'Initializing...'

  $('ul.nav li').removeClass 'active'
  $('ul.nav li#checklists_all').addClass 'active'

  $scope.startChecklistDialog = (template_id) ->
    modalInstance = $modal.open
      templateUrl: "/assets/partials/checklist_new.html"
      controller: ChecklistNewCtrl
      resolve:
          template_id: ->
            template_id

    modalInstance.result.then (checklist) ->
      $scope.startChecklist(template_id, checklist)

  $scope.startChecklist = (template_id, checklist) ->
    # Create and redirect to the new checklist
    Checklists.save {template_id: template_id, name: checklist.name, public: checklist.public, ticket_number: checklist.ticket_number},
      (data) ->
        # Success
        template = _.findWhere($scope.templates, id: template_id)
        # Increment the checklict count of the selected template
        Templates.update {id: template_id, checklist_count: template.checklist_count + 1}
        $location.path("/checklists/#{data.id}")
        $rootScope.active_count++
    , (data) ->
        # Error
        $scope.error = "Error creating a new checklist"
        _.each(data.data.errors , (e,i) ->
            $scope.error = $scope.error + "<li>#{i} #{e}</li>"
          )

  $scope.confirmDeleteTemplate = (template) ->
    modalInstance = $modal.open
      templateUrl: "/assets/partials/template_delete.html"
      controller: TemplateDeleteCtrl
      resolve:
        template: ->
          template

    modalInstance.result.then () ->
      $scope.deleteTemplate(template)

  $scope.deleteTemplate = (template) ->
    Templates.delete {id: template.id},
      (data) ->
        # Success
        index = $scope.templates.indexOf(template)
        $scope.templates.splice(index,1)
        $rootScope.template_count = $scope.templates.length
    , (data) ->
        # Error
        $scope.error = "Error deleting template '#{template.name}'"

  $scope.clearError = ->
    $scope.error = null

  $scope.$watch "search", (value) ->
    if value
      $scope.templates = _.filter($scope.allTemplates, (t) ->
          t.name.toLowerCase().indexOf(value.toLowerCase()) != -1
        )
    else
      $scope.templates = $scope.allTemplates
  , true
