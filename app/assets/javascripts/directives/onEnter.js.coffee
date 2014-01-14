Chekhov.directive "onBlur", @onBlur = () ->
  (scope, element, attrs) ->
    element.bind "blur", (event) ->
      scope.$apply ->
        scope.$eval attrs.onBlur

        event.preventDefault()
