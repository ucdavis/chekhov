Chekhov.controller "TemplatesIndexCtrl", @TemplatesIndexCtrl = ($scope, $modal, $location, Templates, Checklists, User, navDisplayService) ->
  $scope.loaded = false
  $scope.error = null
  $scope.templates = Templates.query {},
    (data) ->
      # Success
      $scope.loaded = true
      navDisplayService.updateTotalTemplate $scope.templates.length
  , (data) ->
      # Error
      $scope.error = "Error retrieving information from server"

  $scope.allTemplates = $scope.templates
    
  $scope.activeTab = 1
  $scope.user = User
  
  console.debug 'TemplatesIndexCtrl', 'Initializing...'

  $('ul.nav li').removeClass 'active'
  $('ul.nav li#checklists_all').addClass 'active'

  $scope.startChecklist = (template_id) ->
    modalInstance = $modal.open
      templateUrl: "/assets/partials/checklist_new.html"
      controller: ChecklistNewCtrl
      resolve:
          template_id: ->
            template_id

    modalInstance.result.then (checklist) ->
      # Create and redirect to the new checklist
      Checklists.save {template_id: template_id, name: checklist.name, public: checklist.public, user_id: User.id},
        (data) ->
          # Success
          template = _.findWhere($scope.templates, id: template_id)
          # Increment the checklict count of the selected template
          Templates.update {id: template_id, checklist_count: template.checklist_count + 1}
          $location.path("/checklists/#{data.id}")
          navDisplayService.incrementActiveTotal "inc"
      , (data) ->
          # Error
          $scope.error = "Error creating a new checklist"
          _.each(data.data.errors , (e,i) ->
              $scope.error = $scope.error + "<li>#{i} #{e}</li>"
            )

  $scope.deleteTemplate = (template) ->
    modalInstance = $modal.open
      templateUrl: "/assets/partials/template_delete.html"
      controller: TemplateDeleteCtrl

    modalInstance.result.then () ->
      Templates.delete {id: template.id},
        (data) ->
          # Success
          index = $scope.templates.indexOf(template)
          $scope.templates.splice(index,1)
          navDisplayService.updateTotalTemplate $scope.templates.length
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
