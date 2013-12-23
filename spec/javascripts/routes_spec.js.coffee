describe "Chekhov Routes", ->

  it "should map routes to controllers", ->
    module "ChekhovApp"
    inject ($route) ->
      expect($route.routes["/"].controller).toBe "TemplatesIndexCtrl"
      expect($route.routes["/"].templateUrl).toEqual "/assets/partials/templates_index.html"

      expect($route.routes["/active"].controller).toBe "TemplatesActiveIndexCtrl"
      expect($route.routes["/active"].templateUrl).toEqual "/assets/partials/templates_active.html"

      expect($route.routes["/archived"].controller).toBe "TemplatesArchivedIndexCtrl"
      expect($route.routes["/archived"].templateUrl).toEqual "/assets/partials/templates_archived.html"

      expect($route.routes["/templates/new"].controller).toBe "TemplateNewCtrl"
      expect($route.routes["/templates/new"].templateUrl).toEqual "/assets/partials/template_new.html"

      expect($route.routes["/templates/edit/:id"].controller).toBe "TemplateEditCtrl"
      expect($route.routes["/templates/edit/:id"].templateUrl).toEqual "/assets/partials/template_edit.html"

      expect($route.routes["/templates/duplicate/:id"].controller).toBe "TemplateDuplicateCtrl"
      expect($route.routes["/templates/duplicate/:id"].templateUrl).toEqual "/assets/partials/template_new.html"

      expect($route.routes["/checklists/:id"].controller).toBe "ChecklistCtrl"
      expect($route.routes["/checklists/:id"].templateUrl).toEqual "/assets/partials/checklist.html"

      # otherwise redirect to
      expect($route.routes[null].redirectTo).toEqual "/"
