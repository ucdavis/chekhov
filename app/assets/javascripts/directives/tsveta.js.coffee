#
# Directive: tsveta (attribute)
#
# Changes the color of the nav-sidebar border according to the current page
# (plain javascript in the main template handles hovers)
#
# Usage example:
# <div class="nav-sidebar col-md-3" tsveta></div>
#

Chekhov.directive "tsveta", @tsveta = () ->
    restrict: "A"
#    scope:
#        tsveta: '='
    link: (scope, element, attrs) ->
        prev_class = ""
#        scope.$watch 'tsveta', ->
        scope.$watch attrs['tsveta'], ->
            if not element.find('li.active').get(0)
                return
            element.removeClass prev_class
            new_class = prev_class = element.find('li.active').get(0).id
            element.addClass new_class
