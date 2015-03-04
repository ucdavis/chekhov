#
# Directive: save-notification (tag)
#
# Includes a template for displaying a green "Saved" notification. Specified
# with an element.
#
# Usage example:
#   In a partial (use show to specify function name to assign to scope.notify in
#   directive):
#       <save-notification show="showNote"></save-notification>
#   In a controller:
#       showNote = "Your message here"
#

Chekhov.directive "saveNotification", @ckvClick = () ->
    restrict: "E"
    template: '<div class="alert alert-success affix notification-alert" style="bottom: 0; right: 15px; z-index: 1;" ng-show="saved"> <strong>{{saved}}</strong> </div>'
    scope:
        show: '='
    controller: ["$scope", "$timeout",
        ($scope, $timeout) ->
            # Shouldn't disappear in three seconds when the message is
            # "Saving..." Seems confusing when saving disappears while something
            # is still saving.
            $scope.saved = $scope.$watch 'show', (mesg) ->
                $scope.saved = mesg
                $timeout.cancel(displayStatus)
                displayStatus = $timeout (->
                    $scope.saved = null
                ), 3000
            ]
