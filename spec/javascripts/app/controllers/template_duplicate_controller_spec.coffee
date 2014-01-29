#= require spec_helper

describe 'TemplateDuplicateCtrl', ->
  beforeEach ->
    @controller('TemplateDuplicateCtrl', { $scope: @scope })
    @Template = @model('Templates')
    @template = new @Template({
        id: 1,
        owner_id: 1,
        name: 'Some template',
        checklist_count: 2,
        url: "http://chekhov.com/templates/1.json",
        entries: [
          {
            content: "First Entry",
            position: 0
          },
          {
            content: "Second Entry",
            position: 1
          },
          {
            content: "Third Entry",
            position: 2
          }
        ]
      })

    @http.whenGET('/templates.json').respond(200, @template)
    @http.flush()

  describe 'entries', ->
    it 'adds to entries', ->
      @scope.newContent = "Entry content"
      @scope.addToEntries()
      expect(@scope.newTemplate.entries_attributes.length).toEqual(4)
      expect(@scope.newTemplate.entries_attributes[3].position).toEqual(3)
      expect(@scope.newContent).toEqual('')

    it "deletes from entries", ->
      @scope.removeFromEntries(0)
      expect(@scope.newTemplate.entries_attributes.length).toEqual(2)
      expect(@scope.newTemplate.entries_attributes[0].content).toEqual "Second Entry"

  describe 'saving', ->
    it "errors out if no name was provided", ->
      @scope.newTemplate.name = ''
      @scope.save()
      expect(@scope.error).toEqual "Please provide a name"

    it "errors out if no entries were provided", ->
      @scope.newTemplate.entries_attributes = []
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
