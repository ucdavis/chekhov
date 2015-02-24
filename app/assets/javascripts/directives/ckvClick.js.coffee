#
# Directive: ckv-click (attribute)
#
# Executes a given action only when a user isn't selecting or deselecting text
# (allows user to select and deselect text from an element without accidentally
# triggering the would-be onclick handler).
#
# Can only be specified as an attribute, with the function (action) specified as
# a string.
#
# Usage example:
# <div ckv-click="dosomething()"></div>
#

Chekhov.directive "ckvClick", @ckvClick = () ->
    restrict: "A"
    scope:
        action: "&ckvClick"
    link: (scope, element, attrs) ->
        #
        # textSelectEvent
        #
        #   Called by mouseup event. Detects if text has been selected or
        #   deselected. 
        #
        #   Arguments: (none)
        #
        #   Returns: (bool) Whether or not text has been selected or deselected.
        #

        textSelectEvent = ->
            # Text only gets deselected (document.getSelection gets cleared)
            # when a mouseup event completes, so document.getSelection should
            # have a string of length > 0 both when selecting and de-selecting
            # text.
            if document.getSelection
                document.getSelection().toString().length > 0
            else if document.selection
                document.selection().createRange().text.length > 0
                

        element.bind
            mouseup: ->
                scope.action()  if not textSelectEvent()
                scope.$apply()
