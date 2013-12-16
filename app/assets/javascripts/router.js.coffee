window.chekhovRouter = ($routeProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "/assets/partials/templates_index.html"
      controller: "TemplatesIndexCtrl"
    .when "/active",
      templateUrl: "/assets/partials/templates_active.html"
      controller: "TemplatesActiveIndexCtrl"
    .when "/templates/new",
      templateUrl: "/assets/partials/template_new.html"
      controller: "TemplateNewCtrl"
    .when "/checklists/:id",
      templateUrl: "/assets/partials/checklist.html"
      controller: "ChecklistCtrl"
