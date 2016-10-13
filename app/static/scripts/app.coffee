'use strict'

angular.module('todoApp', [
  'oauth'
  'ngAnimate'
  'ngCookies'
  'ngResource'
  'ngRoute'
  'ngSanitize'
  'ngTouch'
])

.config(($routeProvider, $locationProvider, $httpProvider) ->
  $routeProvider
  .when('/',
    templateUrl: '/static/views/main.html'
    controller: 'MainCtrl'
    controllerAs: 'main'
  )
  .when('/about',
    templateUrl: '/static/views/about.html'
    controller: 'AboutCtrl'
    controllerAs: 'about'
  )
  .when('/todo',
    templateUrl: '/static/views/todo.html'
    controller: 'TodoCtrl'
    controllerAs: 'todoList'
  )
  .when('/auth',
    templateUrl: '/static/views/auth.html'
    controller: 'AuthCtrl'
    controllerAs: 'auth'
  )
  .otherwise(
    redirectTo: '/'
  )

  $locationProvider.html5Mode
    enabled: true
    requireBase: false

  $httpProvider.interceptors.push 'OAuth2HttpInterceptor'

  return
)
