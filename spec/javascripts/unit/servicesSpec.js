describe("Unit: Testing Services", function() {

  beforeEach(module('ChekhovApp'));

  it('should contain a Templates service',
    inject(function(Templates) {

    expect(Templates).not.to.equal(null);
  }));

  it('should contain a Checklists service',
    inject(function(Checklists) {

    expect(Checklists).not.to.equal(null);
  }));

  it('should contain a User service',
    inject(function(User) {

    expect(User).not.to.equal(null);
  }));

});