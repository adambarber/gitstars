var Reflux = require('reflux');
var Promise = require('bluebird');
var request = require('superagent-bluebird-promise');

var User = require('../models/User');

var FormActions = require('../actions/FormActions.js');

var UserStore = Reflux.createStore({
  listenables: [FormActions],
  requestUser: function(username) {
    return request.get('/api/users/' + username)
  },
  determineWinner: function(leftUser, rightUser) {
    if(leftUser.totalStars > rightUser.totalStars) {
      return 'left';
    } else {
      return 'right';
    }
  },
  onFormSubmit: function(leftUserName, rightUserName) {
    var _self = this;
    var promise = Promise.all([this.requestUser(leftUserName), this.requestUser(rightUserName)])

    promise.then(function(res) {
      var leftUser = new User(res[0].body);
      var rightUser = new User(res[1].body);
      var winner = _self.determineWinner(leftUser, rightUser);
      _self.trigger({
        leftUser: leftUser,
        rightUser: rightUser,
        winner: winner
      })
    });

    promise.catch(function(err) {
      console.log('err', err);
    });

  }
});

module.exports = UserStore;