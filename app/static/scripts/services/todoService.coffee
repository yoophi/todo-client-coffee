class TodoService extends BaseService
  @inject '$http', '$location', '$q', 'Storage', 'AccessToken', 'EndpointConfigService'

  initialize: ->
    storage_token = @Storage.get 'token'
    @access_token = storage_token.access_token ? null
    console.log @access_token
    @todos = []

  _headers: ->
    if @access_token
      return 'Authorization': 'Bearer ' + @access_token

    return {}

  all: ->
    @$http
      .get @EndpointConfigService.getUrl('/todos'),
        'headers': @_headers()

      .success (response) =>
        @todos = response.todos

  create: (obj) ->
    @$http
      .post @EndpointConfigService.getUrl('/todos'),
        obj,
        'headers': @_headers()

      .success (response) =>
        @todos = response.todos

  getRemaining: ->
    count = 0
    angular.forEach @todos, (todo) ->
      count += if todo.done then 0 else 1

    count

  remove: (obj) ->
    @$http
      .delete @EndpointConfigService.getUrl('/todo/' + obj.id),
        'headers': @_headers()
      .success (response) =>
        @todos = response.todos

  archive: ->
    d = []
    angular.forEach @todos, (todo) =>
      if todo.is_completed
        dfd = @remove(todo).success (response) ->
          console.log response
        d.push dfd

    @$q.all(d).then (response) =>
      console.log 'all done', response
      @all()

  update: (obj) ->
    @$http
      .put @EndpointConfigService.getUrl('/todo/' + obj.id),
        'title': obj.title
        'priority': obj.priority
        'is_completed': obj.is_completed
      ,
        'headers': @_headers()
      .success (response) ->
        console.log response


angular
  .module 'todoApp'
  .service 'TodoService', TodoService
