window.chekhovRouter = ($routeProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "/assets/partials/templates_index.html"
      controller: "TemplatesIndexCtrl"
    .when "/open",
      templateUrl: "/assets/partials/templates_open.html"
      controller: "TemplatesOpenIndexCtrl"
    .when "/templates/new",
      templateUrl: "/assets/partials/template_new.html"
      controller: "TemplateNewCtrl"
