angular.module("chekhovServices", ["ngResource"])
  .factory "Templates", ($resource) ->
    $resource "/templates/:id.json",
      id: "@id"
    ,
      update:
        method: "PUT"
      destroy:
        method: "DELETE"
      
  .factory "Checklists", ($resource) ->
    $resource "/checklists/:id.json",
      id: "@id"
    ,
      update:
        method: "PUT"
      destroy:
        method: "DELETE"
      archived:
        method: 'GET'
        isArray:true
        url: '/checklists.json?archived=true'
  .factory "User", () ->
    user = { is_admin: window.is_admin, id: window.user_id }
  .service "navDisplayService", ->
    updateTotalTemplate: (length) ->
      $('ul.nav li#checklists_all a').text "All Checklists (" + length + ")"
    updateTotalActive: (length) ->
      $('ul.nav li#checklists_active a').text "Active Checklists (" + length + ")"
    updateTotalArchived: (length) ->
      $('ul.nav li#checklists_archived a').text "Archived Checklists (" + length + ")"
    incrementActiveTotal: (action) ->
      text = $('ul.nav li#checklists_active a').text()
      start = text.length - 2
      end = text.length - 1
      value = text.slice(start, end)
      newValue = parseInt(value) + 1
      newText = "Active Checklists (" + newValue + ")"
      $('ul.nav li#checklists_active a').text newText
    decrementActiveTotal: (action) ->
      text = $('ul.nav li#checklists_active a').text()
      start = text.length - 2
      end = text.length - 1
      value = text.slice(start, end)
      newValue = parseInt(value) - 1
      newText = "Active Checklists (" + newValue + ")"
      $('ul.nav li#checklists_active a').text newText
    incrementArchivedTotal: (action) ->
      text = $('ul.nav li#checklists_archived a').text()
      start = text.length - 2
      end = text.length - 1
      value = text.slice(start, end)
      newValue = parseInt(value) + 1
      newText = "Archived Checklists (" + newValue + ")"
      $('ul.nav li#checklists_archived a').text newText
    decrementArchivedTotal: (action) ->
      text = $('ul.nav li#checklists_archived a').text()
      start = text.length - 2
      end = text.length - 1
      value = text.slice(start, end)
      newValue = parseInt(value) - 1
      newText = "Archived Checklists (" + newValue + ")"
      $('ul.nav li#checklists_archived a').text newText
