Chekhov.controller "AnalyticsCtrl", @AnalyticsCtrl = ($scope, User, Checklists, Templates, Analytics) ->
#    $scope.checklists2 = Analytics.query {}

    # Get new analytics
    analytics = (start, end) ->
        if start and end
            Analytics.get {
                'start': start.toISOString()
                'end': end.toISOString()
            }
        else
            Analytics.get {}

    # Default Dates
    $scope.endDate = new Date()
    $scope.startDate = new Date()
    $scope.startDate.setMonth($scope.endDate.getMonth() - 1)

    #
    # calendarWatcher: Changes analytics displayed when dates change
    #
    calendarWatcher = (newVal, oldVal) ->
        if newVal isnt oldVal
            $scope.generalStats()
        return

    # Change the statistics displayed when the user changes the start/end dates
    # (see calendarWatcher)
    $scope.$watch 'startDate', calendarWatcher
    $scope.$watch 'endDate', calendarWatcher

    # Stuff for keeping track of which calendar is open
    $scope.startOpened = false
    $scope.endOpened = false

    # Variable for keeping track of which stats are being displayed
    $scope.general = true

    # START Calendar options
    #
    $scope.dateOptions =
      formatYear: 'yyyy',
      startingDay: 0
      showWeeks: false

    $scope.format = "MMMM dd, yyyy"

    $scope.open = (opened, e) ->
        $scope[opened] = true
    #
    # END Calendar options

    #
    # $scope.getItemFrom
    #
    #   Puts into $scope an item from an object returned by a promise
    #

    $scope.getItemFrom = (name, aPromise) ->
        aPromise.then (data) ->
            $scope[name] = data[name]


    #
    # $scope.generalStats
    #
    #   Gets analytics/statistics for a time period starting from
    #   $scope.startDate, and ending $scope.endDate
    #
    
    $scope.generalStats = ->
        $scope.analytics = analytics $scope.startDate, $scope.endDate
        $scope.getItemFrom("checklists", $scope.analytics.$promise)
        $scope.getItemFrom("visits", $scope.analytics.$promise)
        $scope.general = true


    #
    # $scope.allTimeStats: Same as $scope.generalStats, but for all time
    #

    $scope.allTimeStats = ->
        $scope.analytics = analytics()
        $scope.getItemFrom("checklists", $scope.analytics.$promise)
        $scope.getItemFrom("visits", $scope.analytics.$promise)
        $scope.general = false


    #
    # fallsWithin
    #
    #   Returns function that tests whether or not given date (specified as a
    #   string referencing the name of an element of an object) falls within two
    #   given dates.
    #
    #   Arguments:
    #       name: name of the object
    #       start: start date
    #       end: end date
    #

    fallsWithin = (name, start, end) ->
        # Allow everything through if there's no start or end date
        if not (start && end)
            return (item) -> true

        (item) ->
            testDate = new Date(item[name])
            start <= testDate && testDate <= end


    #
    # $scope.meanOf: Returns mean visits per day
    #

    $scope.meanOf = (list) ->
        if not list
            return "0"

        total = _.foldl list, (total, item) ->
                   total + item.number
                  ,
                   0

        total / list.length


    #
    # $scope.calcOpen
    #
    #   Calculates mean duration for which checklists are open. Returns a string
    #   expressing this mean duration in days, hours, and minutes.
    #

    $scope.calcOpen = (list) ->
        finished = _.filter list, (item) -> item.started and item.finished
        total = _.foldl finished, (total, item) ->
                 total + item.time_elapsed
                ,
                 0
        mean = total / finished.length

        # Generally, when there's no checklists in a time period, the average
        # time a checklist took for that given time period is 0/0, or somewhere
        # between undefined and undefined. To avoid showing this result when no
        # checklists are in a time period, instead display "0 minutes."
        if isNaN mean
            return "0 minutes"

        # In all other cases, figure out how many days, hours, and minutes we're
        # talking about.

        stringified = new Array()

        if mean >= 1440
            stringified.push (Math.floor mean/1440) + " days"
            mean = mean % 1440

        if mean >= 60
            stringified.push (Math.floor mean/60) + " hours"
            mean = mean % 60

        stringified.push (Math.round mean) + " minutes"

        stringified.join(", ")
        

    #
    # $scope.haveSysaidNumber
    #
    #   Returns the lists that have a sysaid number
    #

    $scope.haveSysaidNumber = (list) ->
        _.filter list, (item) ->
            list.ticket_number


    #
    # $scope.calcCreated
    #
    #   Using the dataset represented by $scope.checklists, calculates the
    #   number of checklists created in a certain date range.
    #

    $scope.created = (list) ->
        _.filter list,
            fallsWithin('started', $scope.startDate, $scope.endDate)


    #
    # $scope.calcFinished: analagous to calcCreated, but for finished checklists
    #

    $scope.finished = (list) ->
        _.filter list,
            fallsWithin('finished', $scope.startDate, $scope.endDate)


    #
    # $scope.byUsers: Groups a list by the user who created the list
    #

    $scope.byUsers = (list) ->
        _.groupBy list, (item) -> item.user.loginid  if item.user


    #
    # $scope.countByUsers: Returns counts for each user
    #

    $scope.countByUsers = (list) ->
        _.countBy list, (item) -> item.user.loginid  if item.user


    # Show general stats by default
    $scope.generalStats()
