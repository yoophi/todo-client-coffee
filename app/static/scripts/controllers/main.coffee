class MainCtrl extends BaseController
  initialize: ->
    @awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]

angular
  .module 'todoApp'
  .controller 'MainCtrl', MainCtrl