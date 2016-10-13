OAuth2HttpInterceptor = ($q, $location, $log, $rootScope, Storage) ->
  'request': (config) ->
    config

  'requestError': (rejection) ->
    $q.reject rejection

  'response': (response) ->
    response

  'responseError': (rejection) ->
    if rejection.status == 401
      try
        alert rejection.data.message

      Storage.delete 'token'
      $rootScope.$broadcast 'oauth:expired'
      $location.path '/auth'

    $q.reject rejection


angular
  .module 'todoApp'
  .factory 'OAuth2HttpInterceptor', OAuth2HttpInterceptor