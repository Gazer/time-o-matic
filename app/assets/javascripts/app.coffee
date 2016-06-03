toc = angular.module('time-o-matic',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
])

toc.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'TimesController'
      )
])

toc.filter('asDuration', ->
  (input) ->
    duration = moment.duration(input, 'seconds');
    h = ("0" + duration.hours()).slice(-2)
    m = ("0" + duration.minutes()).slice(-2)
    s = ("0" + duration.seconds()).slice(-2)
    "#{h}:#{m}:#{s}"
)

controllers = angular.module('controllers',[])
controllers.controller("TimesController", [ '$scope', '$routeParams', '$location', '$resource', '$interval'
  ($scope, $routeParams, $location, $resource, $interval) ->
    timer = null

    TrackedTime = $resource('/tracked_times.json', { },
      {
        'save':   {method: 'PUT'},
        'create': {method: 'POST'},
        'current': {method: 'GET', url: '/tracked_times/current.json', isArray: false}
        'stop': {method: 'PUT', url: '/tracked_times/stop.json', isArray: false}
      })

    loadAll = ->
      TrackedTime.query((results) ->
        $scope.times = results
        $scope.total = 0
        for result in results
          $scope.total += result.duration
      )

    loadAll()

    TrackedTime.current((result) ->
      $scope.current = result
      if (result)
        timer = $interval( ->
            $scope.current.duration += 1
          , 1000)
    )

    onError = (_httpResponse)-> console.log "Something went wrong"

    $scope.startTracking = (newTrackedTime) ->
      TrackedTime.create(newTrackedTime,
        ( (trackedTime) ->
          $scope.current = trackedTime
          timer = $interval( ->
              $scope.current.duration += 1
            , 1000)),
        onError
      )

    $scope.stopTracking = ->
      TrackedTime.stop(
        ( (result) ->
          $scope.current = null
          $interval.cancel(timer);
          loadAll()
        ),
        onError
      )
])
