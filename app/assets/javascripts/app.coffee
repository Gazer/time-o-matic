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
