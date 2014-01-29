#= require spec_helper

describe 'TemplatesActiveIndexCtrl', ->
  beforeEach ->
    @controller('TemplatesActiveIndexCtrl', { $scope: @scope })
    @Checklist = @model('Checklists')
    @checklists = [
      new @Checklist({
        id: 1,
        name: "First Active Checklist",
        template_name: "First Template",
        public: true,
        user_id: 1,
        started: "2014-01-21T23:48:32.916-08:00",
        finished: "2014-01-27T21:35:16.672-08:00",
        ticket_number: 20422
      }),
      new @Checklist({
        id: 2,
        name: "Second Active Checklist",
        template_name: "Second Template",
        public: false,
        user_id: 2,
        started: "2014-01-22T12:48:32.916-08:00",
        finished: "2014-01-23T13:35:16.672-08:00",
        ticket_number: 20423
      })
    ]

    @http.whenGET('/checklists.json').respond(200, @checklists)
    @http.flush()

  describe 'load active checklists', ->
    it 'sets up the list of active checklists', ->
      expect(@scope.checklists.length).toEqual(2)
      expect(@scope.error).toBeNull()

  describe 'delete a checklist', ->
    it 'displays confirmation before delete', ->
      @http.expectGET('/assets/partials/checklist_delete.html').respond(200, '')
      @scope.confirmDeleteChecklist({ id: 2 })
      @http.flush()

    it 'deletes a checklist', ->
      @http.expectDELETE('/checklists/2.json').respond(204, '')
      @scope.deleteChecklist({ id: 2 })
      @http.flush()
      expect(@scope.checklists.length).toEqual(1)

  describe 'checklist navigation', ->
    it 'navigates to the selected checklist', ->
      @scope.openChecklist(1)
      expect(@location.$$url).toEqual('/checklists/1')

  describe 'error variable', ->
    it 'clears the error', ->
      @scope.error = 'Fatal error!'
      @scope.clearError()
      expect(@scope.error).toBeNull()

  describe 'search', ->
    it 'searches for checklists by name or ticket number', ->
      @scope.search = 'second'
      @scope.$apply()
      expect(@scope.checklists.length).toEqual(1)
      expect(@scope.checklists[0].id).toEqual(2)
      @scope.search = '20422'
      @scope.$apply()
      expect(@scope.checklists.length).toEqual(1)
      expect(@scope.checklists[0].id).toEqual(1)
