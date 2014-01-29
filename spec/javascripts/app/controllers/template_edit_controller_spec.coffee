#= require spec_helper

describe 'TemplateEditCtrl', ->
  beforeEach ->
    @controller('TemplateEditCtrl', { $scope: @scope })
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

  describe 'load template', ->
    it 'loads the template with a GET request', ->
      expect(@scope.template.id).toEqual(1)

  describe 'entries', ->
    it 'adds to entries', ->
      @scope.newContent = "Entry content"
      @scope.addToEntries()
      expect(@scope.template.entries_attributes.length).toEqual(4)
      expect(@scope.position).toEqual(4)
      expect(@scope.newContent).toEqual('')

    it "deletes from entries", ->
      @scope.newContent = "Some Entry"
      @scope.addToEntries()
      @scope.removeFromEntries(3)
      expect(@scope.template.entries_attributes[3]._destroy).toBeTruthy()

  describe 'saving', ->
    it "errors out if no name was provided", ->
      @scope.template.name = ''
      @scope.save()
      expect(@scope.error).toEqual "Please provide a name"

    it "errors out if no entries were provided", ->
      @scope.template.entries_attributes = []
      @scope.save()
      expect(@scope.error).toEqual "Please provide at least one checklist item"

    it "saves the template", ->
      @http.expectPUT('/templates/1.json').respond(201, {})
      @scope.newContent = "Some Entry"
      @scope.addToEntries()
      @scope.removeFromEntries(2)
      @scope.save()
      @http.flush()
      expect(@location.$$url).toEqual('/')

  describe 'error variable', ->
    it 'clears the error', ->
      @scope.error = 'Fatal error!'
      @scope.clearError()
      expect(@scope.error).toBeNull()
