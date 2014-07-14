Chekhov.controller "TemplatesArchivedIndexCtrl", @TemplatesArchivedIndexCtrl = ($scope, $location, Checklists, $rootScope) ->
  $scope.loaded = false
  $scope.error = null
  $scope.checklists = Checklists.archived {},
    (data) ->
      # Success
      $scope.loaded = true
      $rootScope.archived_count = $scope.checklists.length
  , (data) ->
      # Error
      $scope.error = "Error retrieving information from server"

  $scope.allArchived = $scope.checklists

  console.debug 'TemplatesArchivedIndexCtrl', 'Initializing...'

  #$('ul.nav li').removeClass 'active'
  #$('ul.nav li#checklists_archived').addClass 'active'

  $scope.openChecklist = (checklist_id) ->
    $location.path("/checklists/#{checklist_id}")

  $scope.clearError = ->
    $scope.error = null

  $scope.$watch "search", (value) ->
    if value
      $scope.checklists = _.filter($scope.allArchived, (c) ->
          name = c.name.toLowerCase()
          ticket = c.ticket_number || ""
          name.indexOf(value.toLowerCase()) != -1 || ticket.toString().indexOf(value.toLowerCase()) != -1
        )
    else
      $scope.checklists = $scope.allArchived
  , true


  # typeahead search code below

  $scope.selectedNumber = null
  
  # instantiate the bloodhound suggestion engine
  numbers = new Bloodhound(
    datumTokenizer: (d) ->
      Bloodhound.tokenizers.whitespace d.num

    queryTokenizer: Bloodhound.tokenizers.whitespace
    local: [
      {
        num: "one"
      }
      {
        num: "two"
      }
      {
        num: "three"
      }
      {
        num: "four"
      }
      {
        num: "five"
      }
      {
        num: "six"
      }
      {
        num: "seven"
      }
      {
        num: "eight"
      }
      {
        num: "nine"
      }
      {
        num: "ten"
      }
    ]
  )
  
  # initialize the bloodhound suggestion engine
  numbers.initialize()
  $scope.numbersDataset =
    displayKey: "num"
    source: numbers.ttAdapter()

  $scope.addValue = ->
    numbers.add num: "twenty"
    return

  $scope.setValue = ->
    $scope.selectedNumber = num: "seven"
    return

  $scope.clearValue = ->
    $scope.selectedNumber = null
    return

  
  # Typeahead options object
  $scope.exampleOptions = highlight: true
  $scope.exampleOptionsNonEditable =
    highlight: true
    editable: false # the new feature
  
  $scope.getItems = ->
    
