class NavCtrl extends BaseController
  @inject '$scope', 'Storage'

  isLoggedIn: ->
    storage_token = @Storage.get 'token'
    if storage_token and storage_token.access_token
      return true

    return false


angular
  .module 'todoApp'
  .controller 'NavCtrl', NavCtrl
