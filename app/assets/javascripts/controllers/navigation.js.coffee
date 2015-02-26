Chekhov.controller "NavigationCtrl", @NavigationCtrl = ($scope, $location, User) ->
    $scope.user = User
    $scope.isActive = (location) ->
        location is $location.path()
