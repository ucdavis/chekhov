window.chekhovRouter = ($routeProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "/assets/partials/templates.html"
      controller: "TemplatesCtrl"
