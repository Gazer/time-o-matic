describe "TimesController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null
  httpBackend  = null

  setupController = (results, current) ->
    inject(($location, $routeParams, $rootScope, Restangular, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = Restangular
      routeParams = $routeParams

      # capture the injected service
      httpBackend = $httpBackend
      request = new RegExp("\/tracked_times")
      httpBackend.expectGET(request).respond(results || [])

      request = new RegExp("\/tracked_times/current")
      httpBackend.expectGET(request).respond(current || undefined)


      ctrl        = $controller('TimesController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("time-o-matic"))
  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    beforeEach ->
      setupController()
      httpBackend.flush()

    it 'defaults to no empty times', ->
      expect(scope.times).toEqualData([])

  describe 'with tracked times', ->
    times = [
      {
        id: 1
        name: 'Tracked time 1'
        duration: 100
        running: false
      },
      {
        id: 2
        name: 'Tracked time 2'
        duration: 200
        running: false
      }
    ]
    current = {
      id: 3
      name: 'Tracked time 3'
      duration: 10
      running: true
    }
    beforeEach ->
      setupController(times, current)

    it 'calls the back-end', ->
      httpBackend.flush()
      expect(scope.times.plain()).toEqualData(times)

    it 'fetch the current active track', ->
      httpBackend.flush()
      expect(scope.current.plain()).toEqualData(current)

  describe 'copy', ->
    beforeEach ->
      setupController(null, {id: 3, name: 'a name', duration: 1, running: false})
      request = new RegExp("\/tracked_times/.*/copy")
      httpBackend.expectPUT(request).respond(204, {id: 4, name: 'a name', duration: 1, running: true})

    it 'can start a new track copying an old one', ->
      scope.copy(3)
      httpBackend.flush()
      expect(scope.current.name).toBe('a name')

  describe 'delete' ,->
    times = [
      {
        id: 1
        name: 'Tracked time 1'
        duration: 100
        running: false
      },
      {
        id: 2
        name: 'Tracked time 2'
        duration: 200
        running: false
      }
    ]
    beforeEach ->
      setupController()
      scope.times = times
      httpBackend.flush()
      request = new RegExp("\/tracked_times/.*")
      httpBackend.expectDELETE(request).respond(204)

    it 'posts to the backend', ->
      scope.delete(1)
      httpBackend.flush()

      expect(scope.times).toEqualData([{
        id: 2
        name: 'Tracked time 2'
        duration: 200
        running: false
      }])
