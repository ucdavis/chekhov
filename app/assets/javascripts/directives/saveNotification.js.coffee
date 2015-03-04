#
# Directive: save-notification (tag)
#
# Includes a template for displaying a green "Saved" notification. Specified
# with an element.
#
# Usage example:
#   In a partial (use show to specify function name to assign to scope.notify in
#   directive):
#       <save-notification show="showNote" no-timeout="noTimeout"></save-notification>
#   In a controller:
#       showNote = "Your message here"
#       noTimeout = false
#

Chekhov.directive "saveNotification", @ckvClick = () ->
    restrict: "E"
    template: '<div class="alert alert-success affix notification-alert" style="bottom: 0; right: 15px; z-index: 1;" ng-show="saved"> <strong>{{saved}}</strong> </div>'
    scope:
        show: '='
        noTimeout: '='
    controller: ["$scope", "$timeout",
        ($scope, $timeout) ->
            $scope.saved = $scope.$watch 'show', (mesg) ->
                $scope.saved = mesg
                $timeout.cancel(displayStatus)
                unless $scope.noTimeout is true
                    displayStatus = $timeout (->
                        $scope.saved = null
                    ), 3000
            ]
