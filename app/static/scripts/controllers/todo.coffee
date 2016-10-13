class TodoCtrl extends BaseController
  @inject '$scope', 'TodoService'

  getTodos: ->
    @TodoService.all().then (result) =>
      @todos = result.data.todos

  addTodo: ->
    @TodoService.create
      title: @todoText
      done: false
    .then (result) =>
      @todoText = ''
      @getTodos()

  remaining: ->
    @TodoService.getRemaining()

  archive: ->
    @TodoService.archive().then (result) =>
      @todos = result.data.todos

  updateTodo: (obj) ->
    @TodoService.update(obj).then (result) =>
      @getTodos()

  initialize: ->
    @todos = []
    @getTodos()


angular
  .module 'todoApp'
  .controller 'TodoCtrl', TodoCtrl
