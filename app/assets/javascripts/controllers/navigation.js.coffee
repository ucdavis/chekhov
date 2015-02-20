Chekhov.controller "NavigationCtrl", @NavigationCtrl = ($scope, $location) ->
    $scope.isActive = (location) ->
        location is $location.path()

