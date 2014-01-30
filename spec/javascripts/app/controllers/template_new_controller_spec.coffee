#= require spec_helper

describe 'TemplateNewCtrl', ->
  beforeEach ->
    @rootScope.template_count = 2
    @controller('TemplateNewCtrl', { $scope: @scope })

  describe 'entries', ->
    it 'adds to entries', ->
      @scope.newContent = "Entry content"
      @scope.addToEntries()
      expect(@scope.newTemplate.entries_attributes.length).toEqual(1)
      expect(@scope.newTemplate.entries_attributes[0].position).toEqual(0)
      expect(@scope.newContent).toEqual('')

    it "deletes from entries", ->
      @scope.newContent = "First Entry"
      @scope.addToEntries()
      @scope.newContent = "Second Entry"
      @scope.addToEntries()
      @scope.removeFromEntries(0)
      expect(@scope.newTemplate.entries_attributes.length).toEqual(1)
      expect(@scope.newTemplate.entries_attributes[0].content).toEqual "Second Entry"

  describe 'saving', ->
    it "errors out if no name was provided", ->
      @scope.save()
      expect(@scope.error).toEqual "Please provide a name"

    it "errors out if no entries were provided", ->
      @scope.newTemplate.name = "Some name"
      @scope.save()
      expect(@scope.error).toEqual "Please provide at least one checklist item"

    it "saves the template", ->
      @http.expectPOST('/templates.json').respond(201, {})
      @scope.newTemplate.name = "Some name"
      @scope.newContent = "Some Entry"
      @scope.addToEntries()
      @scope.save()
      @http.flush()
      expect(@location.$$url).toEqual('/')
      expect(@rootScope.template_count).toEqual 3

  describe 'error variable', ->
    it 'clears the error', ->
      @scope.error = 'Fatal error!'
      @scope.clearError()
      expect(@scope.error).toBeNull()
