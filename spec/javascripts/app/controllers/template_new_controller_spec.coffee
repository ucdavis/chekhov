#= require spec_helper

describe 'TemplateNewCtrl', ->
  beforeEach ->
    @controller('TemplateNewCtrl', { $scope: @scope })

  describe 'entries', ->
    it 'adds to entries', ->
      @scope.newContent = "Entry content"
      @scope.addToEntries()
      expect(@scope.newTemplate.entries_attributes.length).toEqual(1)
      expect(@scope.newTemplate.entries_attributes[0].position).toEqual(0)
      expect(@scope.newContent).toEqual('')

    it "deletes from entries", ->
      @scope.newContent = "Some Entry"
      @scope.addToEntries()
      @scope.removeFromEntries({content: "Some Entry", position: 0})
      expect(@scope.newTemplate.entries_attributes.length).toEqual(0)

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

  describe 'error variable', ->
    it 'clears the error', ->
      @scope.error = 'Fatal error!'
      @scope.clearError()
      expect(@scope.error).toBeNull()
