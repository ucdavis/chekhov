# Support for Rails' CSRF token
includeCSRF = ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")

window.Chekhov = angular.module("ChekhovApp", ["ngRoute", "ngSanitize","chekhovServices","ui.bootstrap","ui.sortable", "siyfion.sfTypeahead"])
Chekhov.config chekhovRouter
Chekhov.config includeCSRF
Chekhov.config ["$tooltipProvider", ($tooltipProvider) ->
  $tooltipProvider.setTriggers
    click: "click"
    never: "click" # <- This ensures the tooltip will go away on click
]
