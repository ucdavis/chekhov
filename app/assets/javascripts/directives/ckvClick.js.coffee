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
    #
    # These variables are shared across instances of ckv-click, so clicking in
    # one element using ckv-click to clear a text selection in another element
    # doesn't trigger the event.
    #
    textSelected = false
    textDeselected = false

    restrict: "A"
    scope:
        action: "&ckvClick"
    link: (scope, element, attrs) ->
        #
        # textSelectEvent
        #
        #   Detects if text has been selected.
        #
        #   Arguments: (none)
        #
        #   Returns: (bool) Whether or not text has been selected or deselected.
        #

        textSelectEvent = ->
            if document.getSelection
                document.getSelection().toString().length > 0
            else if document.selection
                document.selection().createRange().text.length > 0
            else
                false


        #
        # checkTextDeselect
        #
        #   Called by mousedown event. Detects if text was deselected on
        #   mousedown (occurs when user clicks outside of the selected text to
        #   deselect)
        #
        #   Arguments: (none)
        #
        #   Returns: (none)
        #
        #   Side effects: May cause your textDeselected variable to change
        #       unexpectedly. Please call your doctor if your textDeselected
        #       variable experiences any unusual bleeding.
        #

        checkTextDeselect = ->
            textDeselected = textSelected && textSelectEvent()

    
        #
        # textWasSelected
        #
        #   Called by mouseup event. Returns if text has been selected or
        #   deselected.
        #

        textWasSelected = ->
            textSelected = textSelectEvent()
            textSelected || textDeselected
            

        element.bind
            mousedown: ->
                checkTextDeselect()
                # Both scope.$apply() and return true allow the event to
                # continue normally, which is what we want for mousedown.
                true
#                scope.$apply()
            mouseup: ->
                scope.action()  if not textWasSelected()
                scope.$apply()
