// Generated by CoffeeScript 1.10.0
var NavCtrl,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

NavCtrl = (function(superClass) {
  extend(NavCtrl, superClass);

  function NavCtrl() {
    return NavCtrl.__super__.constructor.apply(this, arguments);
  }

  NavCtrl.inject('$scope', 'Storage');

  NavCtrl.prototype.isLoggedIn = function() {
    var storage_token;
    storage_token = this.Storage.get('token');
    if (storage_token && storage_token.access_token) {
      return true;
    }
    return false;
  };

  return NavCtrl;

})(BaseController);

angular.module('todoApp').controller('NavCtrl', NavCtrl);
