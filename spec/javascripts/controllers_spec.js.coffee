describe "chekhov controllers", -> 
  beforeEach module("ChekhovApp") 
 
  describe "TemplatesIndexCtrl", -> 
    it "should make sure error is initially null", inject(($controller) -> 
      scope = {} 
      ctrl = $controller("TemplatesIndexCtrl", 
        $scope: scope 
      ) 
      expect(scope.error).toBeNull()
    ) 