describe("Midway: Testing Services", function() {

  var tester;
  beforeEach(function() {
    if(tester) {
      tester.destroy();
    }
    tester = ngMidwayTester('ChekhovApp');
  });

  it('should query Templates service and return data', 
    function(done) {

    var $t = tester.inject('Templates');
    expect($t).not.to.equal(null);

    $t.query(function(data) {
      expect(data).not.to.equal(null);
      done();
    });
  });

  it('should query Checklists service and return data', 
    function(done) {

    var $c = tester.inject('Checklists');
    expect($c).not.to.equal(null);

    $c.query(function(data) {
      expect(data).not.to.equal(null);
      done();
    });
  });

});