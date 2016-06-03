controllers = angular.module('controllers')
controllers.controller("TimesController", [ '$scope', '$routeParams', '$location', 'Restangular', '$interval'
  ($scope, $routeParams, $location, Restangular, $interval) ->
    # Controller variables
    trackedTimes = Restangular.all('tracked_times');
    timer = null
    onError = (_httpResponse)-> console.log "Something went wrong"

    # Scope Initialization
    $scope.times = []
    $scope.newTrackedTime = {}
    $scope.flash_error = null
    $scope.times = trackedTimes.getList().$object

    trackedTimes.customGET("current").then (result) ->
      $scope.current = result
      if (result)
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

    $scope.stopTracking = ->
      trackedTimes.customPUT(null, "stop").then(
        (result) ->
          $scope.current = null
          $interval.cancel(timer);
          $scope.times = trackedTimes.getList().$object
        onError
      )

    $scope.delete = (id) ->
      Restangular.one("tracked_times", id).remove();
      $scope.times = trackedTimes.getList().$object
])
