describe("Midway: Testing Controllers and Router", function() {

  var tester;
  beforeEach(function() {
    if(tester) {
      tester.destroy();
    }
    tester = ngMidwayTester('ChekhovApp');
  });

  it('should load the TemplatesIndexCtrl controller properly when / route is accessed', function(done) {
    tester.visit('/', function() {
      tester.path().should.eq('/');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      expect(controller).to.eql('TemplatesIndexCtrl');
      tester.destroy();
      done();
    });
  });

  it('should load the TemplatesActiveIndexCtrl controller properly when /active route is accessed', function(done) {
    tester.visit('/active', function() {
      tester.path().should.eq('/active');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      expect(controller).to.eql('TemplatesActiveIndexCtrl');
      tester.destroy();
      done();
    });
  });

  it('should load the TemplatesArchivedIndexCtrl controller properly when /archived route is accessed', function(done) {
    tester.visit('/archived', function() {
      tester.path().should.eq('/archived');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      expect(controller).to.eql('TemplatesArchivedIndexCtrl');
      tester.destroy();
      done();
    });
  });

  it('should load the TemplateNewCtrl controller properly when /templates/new route is accessed', function(done) {
    tester.visit('/templates/new', function() {
      tester.path().should.eq('/templates/new');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      expect(controller).to.eql('TemplateNewCtrl');
      tester.destroy();
      done();
    });
  });

  it('should load the TemplateEditCtrl controller properly when /templates/edit/:id route is accessed', function(done) {
    tester.visit('/templates/edit/1', function() {
      tester.path().should.eq('/templates/edit/1');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      expect(controller).to.eql('TemplateEditCtrl');
      tester.destroy();
      done();
    });
  });

  it('should load the TemplateDuplicateCtrl controller properly when /templates/duplicate/:id route is accessed', function(done) {
    tester.visit('/templates/duplicate/1', function() {
      tester.path().should.eq('/templates/duplicate/1');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      expect(controller).to.eql('TemplateDuplicateCtrl');
      tester.destroy();
      done();
    });
  });

  it('should load the ChecklistCtrl controller properly when /checklists/:id route is accessed', function(done) {
    tester.visit('/checklists/1', function() {
      tester.path().should.eq('/checklists/1');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      expect(controller).to.eql('ChecklistCtrl');
      tester.destroy();
      done();
    });
  });

  it('should redirect to / when /whatever route is accessed', function(done) {
    tester.visit('/whatever', function() {
      tester.path().should.eq('/');
      tester.destroy();
      done();
    });
  });

});