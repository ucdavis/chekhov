# Support for Rails' CSRF token
includeCSRF = ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")

window.Chekhov = angular.module("ChekhovApp", ["ngRoute", "ngSanitize","chekhovServices","ui.bootstrap","ui.sortable", "siyfion.sfTypeahead", "monospaced.elastic"]).run(
    ($rootScope, $window) ->
        $rootScope.template_count = $window.template_count
        $rootScope.archived_count = $window.archived_count
        $rootScope.active_count = $window.active_count
)
Chekhov.config chekhovRouter
Chekhov.config includeCSRF
Chekhov.config ["$tooltipProvider", ($tooltipProvider) ->
  $tooltipProvider.setTriggers
    click: "click"
    never: "click" # <- This ensures the tooltip will go away on click
]
