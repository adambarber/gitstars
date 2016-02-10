var React = require('react');
var Reflux = require('reflux');

var UserSearchInput = require('./UserSearchInput');
var UserSearchButton = require('./UserSearchButton');

var UserStore = require('../stores/UserStore');

var FormActions = require('../actions/FormActions');

var UserSearch = React.createClass({
  mixins: [Reflux.listenTo(UserStore,"onStatusChange")],
  onStatusChange: function(trigger) {
    this.setState({submitted: false});
  },
  onSubmit: function(e) {
    e.preventDefault();
    if(this.validInput()) {
      this.setState({submitted: true});
      FormActions.formSubmit(this.state.leftUserName, this.state.rightUserName);
    }
  },
  onUsernameChange: function(position, input) {
    username = input === '' ? null : input;
    if(position === 'left') {
      this.setState({leftUserName: username})
    }
    if(position === 'right') {
      this.setState({rightUserName: username})
    }
  },
  validInput: function() {
    return((this.state.leftUserName !== null) && (this.state.rightUserName !== null))
  },
  getInitialState: function() {
    return({
      leftUserName: null,
      rightUserName: null,
      submitted: false
    })
  },
  render: function() {
    var validInput = this.validInput();
    return(
      <div className='user-search-container'>
        <form onSubmit={this.onSubmit}>
          <div className='row'>
            <UserSearchInput position='left' onUsernameChange={this.onUsernameChange}/>
            <UserSearchInput position='right' onUsernameChange={this.onUsernameChange}/>
          </div>
          <div className='row'>
            <UserSearchButton active={validInput} submitted={this.state.submitted}/>
          </div>
        </form>
    </div>
    )
  }
});

module.exports = UserSearch;