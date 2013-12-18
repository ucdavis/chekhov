angular.module("chekhovServices", ["ngResource"])
  .factory "Templates", ($resource) ->
    $resource "/templates/:id.json",
      id: "@id"
    ,
      update:
        method: "PUT"
      destroy:
        method:  "DELETE"
      
  .factory "Checklists", ($resource) ->
    $resource "/checklists/:id.json",
      id: "@id"
    ,
      update:
        method: "PUT"
      archived:
        method: 'GET'
        isArray:true
        url: '/checklists.json?archived=true'
  .factory "User", () ->
    user = { is_admin: window.is_admin, id: window.user_id }
