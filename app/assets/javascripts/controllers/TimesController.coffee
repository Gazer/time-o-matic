controllers = angular.module('controllers')
controllers.controller("TimesController", [ '$scope', '$routeParams', '$location', 'Restangular', '$interval'
  ($scope, $routeParams, $location, Restangular, $interval) ->
    # Controller variables
    trackedTimes = Restangular.all('tracked_times');
    timer = null
    onError = (_httpResponse)-> console.log "Something went wrong"

    # Scope Initialization
    $scope.current = null
    $scope.times = []
    $scope.newTrackedTime = {}
    $scope.flash_error = null
    $scope.times = trackedTimes.getList().$object

    $scope.current = trackedTimes.current().then (result) ->
      $scope.current = result
      if $scope.current
        timer = $interval( ->
            $scope.current.duration += 1
          , 1000)


    # Event handlers
    $scope.clearErrors = ->
      $scope.flash_error = null

    $scope.startTracking = (newTrackedTime) ->
      trackedTimes.post(newTrackedTime).then(
        (result)->
          $scope.newTrackedTime = {}
          $scope.current = result
          timer = $interval( ->
              $scope.current.duration += 1
            , 1000)
        (error) ->
          console.log error.data.error
          $scope.flash_error = error.data.error
      )

    $scope.stopTracking = ()->
      $interval.cancel(timer);
      stopped = trackedTimes.stop().$object
      $scope.current = null
      $scope.times.unshift(stopped)

    $scope.delete = (id) ->
      Restangular.one("tracked_times", id).remove()
      $scope.times = $scope.times.filter (item) -> item.id != id
])
