Chekhov.controller "NavigationCtrl", @NavigationCtrl = ($scope, $location, User) ->
    $scope.user = User
    $scope.location = ->
        $location.path()
    $scope.isActive = (location) ->
        location is $location.path()
