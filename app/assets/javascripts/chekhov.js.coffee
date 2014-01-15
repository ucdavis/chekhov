# Support for Rails' CSRF token
includeCSRF = ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")

window.Chekhov = angular.module("ChekhovApp", ["ngRoute", "ngSanitize","chekhovServices","ui.bootstrap","ui.sortable"])
Chekhov.config chekhovRouter
Chekhov.config includeCSRF
