#= require spec_helper

describe 'ChecklistCtrl', ->
  beforeEach ->
    @controller('ChecklistCtrl', { $scope: @scope })
    @Checklist = @model('Checklists')
    @checklist = new @Checklist({
        id: 1,
        name: "First Active Checklist",
        template_name: "First Template",
        public: true,
        user_id: 1,
        started: "2014-01-21T23:48:32.916-08:00",
        finished: "2014-01-27T21:35:16.672-08:00",
        ticket_number: 20422
        entries: [
          {
            id: 1
            checked: false
            completed_by: null
            content: "one"
            finished: null
            position: 0
          },
          {
            id: 2
            checked: true
            completed_by: null
            content: "two"
            finished: null
            position: 1
          }
        ]
      })

    @http.whenGET('/checklists.json').respond(200, @checklist)
    @http.flush()

  describe 'Loading', ->
    it 'current checklist', ->
      expect(@scope.checklist.id).toEqual(1)
      expect(@scope.error).toBeNull()

  describe 'Changing checklist attributes', ->
    it 'toggles public/not public', ->
      @scope.checklist.entries = @scope.checklist.entries_attributes
      @http.expectPUT('/checklists/1.json').respond(200, @scope.checklist)
      @scope.togglePublic()
      @http.flush()
      expect(@scope.checklist.public).toEqual false

    it "checks/unchecks and entry and saves changes", ->
      @scope.checklist.entries = @scope.checklist.entries_attributes
      @http.expectPUT('/checklists/1.json').respond(200, @scope.checklist)
      @scope.check(@scope.checklist.entries_attributes[0])
      @scope.check(@scope.checklist.entries_attributes[1])
      @http.flush()
      expect(@scope.checklist.entries_attributes[0].checked).toEqual true
      expect(@scope.checklist.entries_attributes[1].checked).toEqual false

  describe 'error variable', ->
    it 'clears the error', ->
      @scope.error = 'Fatal error!'
      @scope.clearError()
      expect(@scope.error).toBeNull()
