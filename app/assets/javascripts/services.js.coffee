angular.module("chekhovServices", ["ngResource"])
  .factory "Templates", ($resource) ->
    $resource "/templates/:id.json",
      id: "@id"
    ,
      update:
        method: "PUT"
      destroy:
        method: "DELETE"
      
  .factory "Checklists", ($resource) ->
    $resource "/checklists/:id.json",
      id: "@id"
    ,
      update:
        method: "PUT"
      destroy:
        method: "DELETE"
      archived:
        method: 'GET'
        isArray:true
        url: '/checklists.json?archived=true'
      all_lists:
        method: 'GET'
        isArray:true
        url: '/checklists.json?all_lists=true'
  .factory "User", () ->
    user = {
        is_admin: window.is_admin,
        id: window.user_id,
        user_name: window.user_name
    }
  .factory "Analytics", ($resource) ->
    $resource "/analytics.json"
  .factory "ChecklistCategories", ($resource) ->
    $resource "/checklist_categories.json"
  .factory "TemplateCategories", ($resource) ->
    $resource "/template_categories.json"
  .factory "ChecklistStarter", (Checklists, Templates, $location, $rootScope) ->
    start: (template) ->
        # Increment the checklist count of the selected template
        count = template.checklist_count + 1
        checklist = {public: true, name: template.name + ' ' + count.toString() }

        # Create and redirect to the new checklist
        Checklists.save {template_id: template.id, name: checklist.name, public: checklist.public},
          (data) ->
            # Success
            # Increment the checklist count of the selected template
            Templates.update {id: template.id, checklist_count: template.checklist_count + 1}
            $location.path("/checklists/#{data.id}").search("new", 1)
            $rootScope.active_count++
        , (data) ->
            # Error
            $scope.error = "Error creating a new checklist"
            _.each(data.data.errors , (e,i) ->
                $scope.error = $scope.error + "<li>#{i} #{e}</li>"
              )

  # For preserving state of loaded templates in the manage template and start
  # new views (see TemplatesIndexCtrl)
  .factory "State", () ->
    {
      categories: []
    }

  # For preserving state (e.g., Colorado, ha ha get it?) of loaded checklists
  # for the active checklist view (see TemplatesActiveIndexCtrl)
  .factory "Colorado", () ->
    {
      whichChecklists:
        startDate: ""
        endDate: ""
        oldDates:
          start: new Date()
          end: new Date()
        inProgress: true
        archived: false
        categories: []
    }
