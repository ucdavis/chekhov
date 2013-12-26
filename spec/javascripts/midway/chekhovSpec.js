describe("Midway: Testing Modules", function() {
  describe("Chekhov Module:", function() {

    var module;
    before(function() {
      module = angular.module("ChekhovApp");
    });

    it("should be registered", function() {
      expect(module).not.to.equal(null);
    });

    describe("Dependencies:", function() {

      var deps;
      var hasModule = function(m) {
        return deps.indexOf(m) >= 0;
      };
      before(function() {
        deps = module.value('ChekhovApp').requires;
      });

      //you can also test the module's dependencies
      it("should have ngRoute as a dependency", function() {
        expect(hasModule('ngRoute')).to.equal(true);
      });

      it("should have chekhovServices as a dependency", function() {
        expect(hasModule('chekhovServices')).to.equal(true);
      });

      it("should have ui.bootstrap as a dependency", function() {
        expect(hasModule('ui.bootstrap')).to.equal(true);
      });

      it("should have ui.sortable as a dependency", function() {
        expect(hasModule('ui.sortable')).to.equal(true);
      });
    });
  });
});