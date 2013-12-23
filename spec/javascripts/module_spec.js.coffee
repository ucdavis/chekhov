describe "Testing Module", ->
  describe "Chekhov Module:", ->
    module = undefined
    beforeEach ->
      module = angular.module("ChekhovApp")

    it "should be registered", ->
      expect(module).not.toEqual null

    describe "Dependencies:", ->
      deps = undefined
      hasModule = (m) ->
        deps.indexOf(m) >= 0

      beforeEach ->
        deps = module.value("ChekhovApp").requires

      
      it "should have ngRoute as a dependency", ->
        expect(hasModule("ngRoute")).toBeTruthy()

      it "should have chekhovServices as a dependency", ->
        expect(hasModule("chekhovServices")).toBeTruthy()

      it "should have ui.bootstrap as a dependency", ->
        expect(hasModule("ui.bootstrap")).toBeTruthy()

      it "should have ui.sortable as a dependency", ->
        expect(hasModule("ui.sortable")).toBeTruthy()
