Chekhov.controller "AnalyticsCtrl", @AnalyticsCtrl = ($scope, User, Checklists, Templates, Analytics) ->
#    $scope.checklists2 = Analytics.query {}

    # Get new analytics
    getAnalytics = (start, end) ->
        if start and end
            Analytics.query {
                'start': start.toISOString()
                'end': end.toISOString()
            }
        else
            Analytics.query {}

    # Default Dates
    $scope.endDate = new Date()
    $scope.startDate = new Date()
    $scope.startDate.setMonth($scope.endDate.getMonth() - 1)

    $scope.checklists = getAnalytics $scope.startDate, $scope.endDate

    # Change analytics displayed when dates change
    calendarWatcher = (newVal, oldVal) ->
        if newVal isnt oldVal
            $scope.checklists = getAnalytics $scope.startDate, $scope.endDate
        return

    $scope.$watch 'startDate', calendarWatcher
    $scope.$watch 'endDate', calendarWatcher

    # Stuff for keeping track of which calendar is open
    $scope.startOpened = false
    $scope.endOpened = false

    # Stuff for keeping track of which stats are being displayed
    $scope.general = true

    # Calendar options
    $scope.dateOptions =
      formatYear: 'yyyy',
      startingDay: 0
      showWeeks: false

    $scope.format = "MMMM dd, yyyy"

    $scope.open = (opened, e) ->
        $scope[opened] = true

    $scope.generalStats = ->
        $scope.checklists = getAnalytics $scope.startDate, $scope.endDate
        $scope.general = true

    $scope.allTimeStats = ->
        $scope.checklists = getAnalytics()
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
