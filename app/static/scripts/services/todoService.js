// Generated by CoffeeScript 1.10.0
var TodoService,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

TodoService = (function(superClass) {
  extend(TodoService, superClass);

  function TodoService() {
    return TodoService.__super__.constructor.apply(this, arguments);
  }

  TodoService.inject('$http', '$location', '$q', 'Storage', 'AccessToken', 'EndpointConfigService');

  TodoService.prototype.initialize = function() {
    var ref, storage_token;
    storage_token = this.Storage.get('token');
    this.access_token = (ref = storage_token.access_token) != null ? ref : null;
    console.log(this.access_token);
    return this.todos = [];
  };

  TodoService.prototype._headers = function() {
    if (this.access_token) {
      return {
        'Authorization': 'Bearer ' + this.access_token
      };
    }
    return {};
  };

  TodoService.prototype.all = function() {
    return this.$http.get(this.EndpointConfigService.getUrl('/todos'), {
      'headers': this._headers()
    }).success((function(_this) {
      return function(response) {
        return _this.todos = response.todos;
      };
    })(this));
  };

  TodoService.prototype.create = function(obj) {
    return this.$http.post(this.EndpointConfigService.getUrl('/todos'), obj, {
      'headers': this._headers()
    }).success((function(_this) {
      return function(response) {
        return _this.todos = response.todos;
      };
    })(this));
  };

  TodoService.prototype.getRemaining = function() {
    var count;
    count = 0;
    angular.forEach(this.todos, function(todo) {
      return count += todo.done ? 0 : 1;
    });
    return count;
  };

  TodoService.prototype.remove = function(obj) {
    return this.$http["delete"](this.EndpointConfigService.getUrl('/todo/' + obj.id), {
      'headers': this._headers()
    }).success((function(_this) {
      return function(response) {
        return _this.todos = response.todos;
      };
    })(this));
  };

  TodoService.prototype.archive = function() {
    var d;
    d = [];
    angular.forEach(this.todos, (function(_this) {
      return function(todo) {
        var dfd;
        if (todo.is_completed) {
          dfd = _this.remove(todo).success(function(response) {
            return console.log(response);
          });
          return d.push(dfd);
        }
      };
    })(this));
    return this.$q.all(d).then((function(_this) {
      return function(response) {
        console.log('all done', response);
        return _this.all();
      };
    })(this));
  };

  TodoService.prototype.update = function(obj) {
    return this.$http.put(this.EndpointConfigService.getUrl('/todo/' + obj.id), {
      'title': obj.title,
      'priority': obj.priority,
      'is_completed': obj.is_completed
    }, {
      'headers': this._headers()
    }).success(function(response) {
      return console.log(response);
    });
  };

  return TodoService;

})(BaseService);

angular.module('todoApp').service('TodoService', TodoService);