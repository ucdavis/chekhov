Chekhov.controller "ChecklistNewCtrl", @ChecklistNewCtrl = ($scope, $modalInstance, Templates, template_id) ->
  $scope.newChecklist = {public: true}
  
  $scope.templates = []
  Templates.query (response) ->
    angular.forEach response, (item) ->
      $scope.templates.push item if item.id

  $scope.$watch "templates", (value) ->
    template = _.findWhere($scope.templates, id: template_id)
    if template
      # Increment the checklict count of the selected template
      count = template.checklist_count + 1
      $scope.newChecklist = {public: true, name: template.name + ' ' + count.toString() }
  , true
  

  $scope.create = ->
    $modalInstance.close $scope.newChecklist

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"