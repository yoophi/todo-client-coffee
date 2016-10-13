class AuthCtrl extends BaseController
  @inject '$scope', '$rootScope', 'Storage', '$timeout', 'AccessToken', 'EndpointConfigService'

  initialize: ->
    @site = @EndpointConfigService.getUrl ''
    @profile_url = @EndpointConfigService.getUrl '/users/self'

    storage_token = @Storage.get 'token'
    if storage_token
      @$scope.accessToken = storage_token.access_token

    @$scope.$on 'oauth:expired', (event) =>
        @$rootScope.accessToken = null
        @$scope.accessToken = null

    @$scope.$on 'oauth:login', (event, token) =>
        @$rootScope.accessToken = token.access_token
        @$scope.accessToken = token.access_token

    @$scope.$on 'oauth:logout', (event) =>
        @$rootScope.accessToken = null
        @$scope.accessToken = null


angular
  .module 'todoApp'
  .controller 'AuthCtrl', AuthCtrl