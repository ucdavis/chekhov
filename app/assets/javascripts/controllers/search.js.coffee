Chekhov.controller "SearchCtrl", @SearchCtrl = ($scope, $timeout, $location, User, Checklists, Templates, ChecklistStarter) ->
    # Only does server queries when the user stops typing for a few hundred
    # milliseconds. Keeps an offline cache for those in-between times for a
    # faster-seeming response. Basically the same thing as Bloodhound
    # remote/prefetch, except for our local AngularJS services.

    localSearcher = (cache, query, key) ->
        list = _.map(
            _.filter cache, (item) -> item.name.toLowerCase().indexOf(query.toLowerCase()) isnt -1
          ,
            (item) ->
                obj = {}
                obj = item
                obj[key] = item.name
                return obj
        )

        # Limit to displaying 10 results per type of entry
        _.take list, 10

    # Queries server for entire data set and calls a callback function with the
    # sorted data. In searcher, the callback function is used to store the
    # sorted cache within searcher.
    getCache = (method, callback) ->
        method {},
            (data) ->
                $('.typeahead').removeClass('loading')
                callback _.sortBy data, (item) -> item.name
          , (data) ->
                console.log "Error retrieving information from server"

    searcher = (method, key) ->
        waiter = null
        cache = null
        fetching = false

        (query, cb) ->
            suggestions = []
            $timeout.cancel waiter

            # Get cache the first time user tries searching something (we don't
            # want it to load right on page load because it slows down the
            # loading of actual content). Keeps track of whether or not we're
            # still waiting on data using "fetching" (don't want to ask for the
            # same data multiple times before getting a single copy of it)
            if cache is null and fetching is false
                fetching = true
                $('.typeahead').addClass('loading')
                getCache method, (data) ->
                    fetching = false
                    cache = data

            # Do local search first for "instant" results
            cb(localSearcher cache, query, key)

            # Do server search to update results in case user wants something
            # not in the cache
            waiter = $timeout (-> method {query},
                (data) ->
                    for i of data
                        obj = {} # Have to keep object within scope of for loop
                                 # because key is always the same. Not doing so
                                 # means overwrites
                        obj = data[i]
                        obj[key] = data[i].name
                        suggestions.push obj  unless isNaN(i)
                    cb suggestions
              ,
                (data) ->
                    $scope.error = "Error retrieving information from server"
            ), 200

    template = (title, key, cssClass) ->
        header: '<div class="tt-header ' + cssClass + '">' + title + '</div>'
        footer: (info) ->
            if not info.isEmpty
                '<div class="border"></div>'
        suggestion: (sugg) ->
            titleTip = "Edit checklist"
            titleTip = "Start new checklist using"  if key is "template"

            suggTemplate = '<p title="' + titleTip + ' &quot;' + sugg[key] + '&quot;">' + sugg[key] + '</p>'

            if User.is_admin and key is "template"
                suggTemplate +
                    '<a href="#/templates/edit/' + sugg.id + '" title="Edit this template" onclick="window.nostart = true">' +
                    '<i class="glyphicon glyphicon-edit"></i></a>'
            else
                suggTemplate
                

    $('.masthead .typeahead').typeahead(
         hint: true
         highlight: true
         minLength: 1
      ,
         name: 'archived'
         displayKey: 'checklist'
         source: searcher Checklists.archived, 'checklist'
         templates: template 'Completed', 'checklist', 'archived'
      ,
         name: 'open'
         displayKey: 'checklist'
         source: searcher Checklists.query, 'checklist'
         templates: template 'In Progress', 'checklist', 'open'
      ,
         name: 'templates'
         displayKey: 'template'
         source: searcher Templates.query, 'template'
         templates: template 'Templates', 'template', 'template'
    )

    # This is what happens when a user clicks on a suggestion or presses the
    # return key on a suggestion.
    navigateAway = (jq, suggestion, dataset) ->
        if dataset is 'archived' or dataset is 'open'
            $location.path '/checklists/' + suggestion.id
            $scope.$apply()
        else
            # Might be good to refactor to use angular's typeahead, so we don't
            # have to set global window variables, don't have to set onclick
            # handlers in attributes, and can use directives and such.
            ChecklistStarter.start suggestion  if window.nostart is false
            window.nostart = false

    $('.typeahead').on 'typeahead:selected', navigateAway
    return 0
