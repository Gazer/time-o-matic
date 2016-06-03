toc = angular.module('time-o-matic',[
  'templates',
  'ngRoute',
  'restangular',
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

toc.config((RestangularProvider) ->
  RestangularProvider.setDefaultHeaders({ "Accept": "application/json" });

  RestangularProvider.addElementTransformer 'tracked_times', true, (user) ->
    user.addRestangularMethod('current', 'get', 'current');
    user

  RestangularProvider.addElementTransformer 'tracked_times', true, (user) ->
    user.addRestangularMethod('stop', 'put', 'stop');
    user
)

toc.filter('asDuration', ->
  (input) ->
    duration = moment.duration(input, 'seconds');
    h = ("0" + duration.hours()).slice(-2)
    m = ("0" + duration.minutes()).slice(-2)
    s = ("0" + duration.seconds()).slice(-2)
    "#{h}:#{m}:#{s}"
)

toc.filter('asTotalDuration', ->
  (input) ->
    if input
      total = 0
      for result in input
        total += result.duration

      duration = moment.duration(total, 'seconds');
      h = ("0" + duration.hours()).slice(-2)
      m = ("0" + duration.minutes()).slice(-2)
      s = ("0" + duration.seconds()).slice(-2)
      "#{h}:#{m}:#{s}"
    else
      "00:00:00"
)

controllers = angular.module('controllers',[])
