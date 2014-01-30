#= require spec_helper

describe 'TemplatesIndexCtrl', ->
  beforeEach ->
    @rootScope.template_count = 2
    @controller('TemplatesIndexCtrl', { $scope: @scope })
    @Template = @model('Templates')
    @templates = [
      new @Template({
        id: 1,
        owner_id: 1,
        name: 'First template',
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
      }),
      new @Template({
        id: 2,
        owner_id: 1,
        name: 'Second template',
        checklist_count: 1,
        url: "http://chekhov.com/templates/2.json",
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
    ]

    @http.whenGET('/templates.json').respond(200, @templates)
    @http.flush()

  describe 'load templates', ->
    it 'sets up the list of current templates', ->
      expect(@scope.templates.length).toEqual(2)

  describe 'delete a template', ->
    it 'displays confirmation before delete', ->
      @http.expectGET('/assets/partials/template_delete.html').respond(200, '')
      @scope.confirmDeleteTemplate({ id: 2 })
      @http.flush()

    it 'deletes a template', ->
      @http.expectDELETE('/templates/2.json').respond(204, '')
      @scope.deleteTemplate({ id: 2 })
      @http.flush()
      expect(@scope.templates.length).toEqual(1)
      expect(@rootScope.template_count).toEqual(1)

  describe 'create a checklist from template', ->
    it 'displays create new checklist dialog', ->
      @http.expectGET('/assets/partials/checklist_new.html').respond(200, '')
      @scope.startChecklistDialog(2)
      @http.flush()

    it 'creates a checklist and redirects to it', ->
      @http.expectPOST('/checklists.json').respond(201, { id:1, public:true, user_id:1, started:"2014-01-23T15:03:59.170-08:00", finished:null, name:"New Checklist", template_name:"Second template","ticket_number":1234})
      @http.expectPUT('/templates/2.json').respond(204, '')
      @scope.startChecklist(2, { name: 'New Checklist', public: true, ticket_number: 1234})
      @http.flush()
      expect(@location.$$url).toEqual('/checklists/1')

  describe 'error variable', ->
    it 'clears the error', ->
      @scope.error = 'Fatal error!'
      @scope.clearError()
      expect(@scope.error).toBeNull()

  describe 'search', ->
    it 'searches for templates by name', ->
      @scope.search = 'second'
      @scope.$apply()
      expect(@scope.templates.length).toEqual(1)
      expect(@scope.templates[0].id).toEqual(2)
