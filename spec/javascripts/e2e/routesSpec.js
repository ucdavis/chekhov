describe("E2E: Testing Routes", function() {

  beforeEach(function() {
    browser().navigateTo('/');
  });

  it('should have a working / route', function() {
    browser().navigateTo('#/');
    expect(browser().window().hash()).toBe("/");
  });

  it('should have a working /archived route', function() {
    browser().navigateTo('#/archived');
    expect(browser().window().hash()).toBe("/archived");
  });

  it('should have a working /templates/new route', function() {
    browser().navigateTo('#/templates/new');
    expect(browser().window().hash()).toBe("/templates/new");
  });

  it('should have a working //templates/edit/:id route', function() {
    browser().navigateTo('#/templates/edit/1');
    expect(browser().window().hash()).toBe("/templates/edit/1");
  });

  it('should have a working /templates/duplicate/:id route', function() {
    browser().navigateTo('#/templates/duplicate/1');
    expect(browser().window().hash()).toBe("/templates/duplicate/1");
  });

  it('should have a working /checklists/:id route', function() {
    browser().navigateTo('#/checklists/1');
    expect(browser().window().hash()).toBe("/checklists/1");
  });

});