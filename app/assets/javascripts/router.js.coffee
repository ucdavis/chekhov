window.chekhovRouter = ($routeProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "/assets/partials/templates_index.html"
      controller: "TemplatesIndexCtrl"
    .when "/templates/new",
      templateUrl: "/assets/partials/template_new.html"
      controller: "TemplateNewCtrl"
