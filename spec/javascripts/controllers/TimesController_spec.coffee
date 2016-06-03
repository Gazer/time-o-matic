describe "TimesController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null

  setupController =(keywords)->
    inject(($location, $routeParams, $rootScope, $resource, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      ctrl        = $controller('TimesController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("time-o-matic"))
  beforeEach(setupController())

  it 'defaults to no tracked time', ->
    expect(scope.current).toBe(undefined)

  it 'defaults to no empty times', ->
    expect(scope.times).toEqualData([])
