class BaseController
  @inject: (args...) ->
    @$inject = args

  constructor: (args...) ->
    for key, index in @constructor.$inject
      this[key] = args[index]
    @scope = @$scope if @$scope?

    for key, fn of @constructor.prototype
      console.log key
      continue if key in ['constructor', 'initialize'] or key[0] is '_'
      do (key) =>
        fn = fn.bind?(this) || _.bind(fn, this) if typeof fn is 'function'
        Object.defineProperty this, key,
          get: -> @scope[key]
          set: (v) -> @scope[key] = v
        @scope[key] = fn

    @initialize?.call(this)
