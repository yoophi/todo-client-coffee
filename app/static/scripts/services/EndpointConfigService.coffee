class EndpointConfigService extends BaseService
  @inject '$rootScope'

  initialize: ->
    @currentEndpoint =
      URI: 'http://todo.yoophi.com/'
      root: 'api/v1.0'
      format: ''

    @userId = null

    @$rootScope.$on 'onCurrentUserId', (event, id) ->
      @userId = id

  getUrl: (model) ->
    @currentEndpoint.URI + @currentEndpoint.root + model

  getUrlForId: (model, id) ->
    @getUrl(model) + id + @currentEndpoint.format

  getCurrentFormat: ->
    @currentEndpoint.format

  getCurrentURI: ->
    @currentEndpoint.URI


angular
  .module 'todoApp'
  .service 'EndpointConfigService', EndpointConfigService