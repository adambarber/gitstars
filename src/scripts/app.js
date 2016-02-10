var React = require('react');
var Reflux = require('reflux');

var ReactDom = require('react-dom');

var Header = require('./components/Header');
var Footer = require('./components/Footer');

var UserSearch = require('./components/UserSearch');
var UserStats = require('./components/UserStats');

var UserStore = require('./stores/UserStore');

var App = React.createClass({
  mixins: [Reflux.listenTo(UserStore,"onStatusChange")],
  onStatusChange: function(trigger) {
    this.setState({
      leftUser: trigger.leftUser,
      rightUser: trigger.rightUser,
      winner: trigger.winner
    })
  },
  getInitialState: function() {
    return({
      leftUser: null,
      rightUser: null,
      winner: null
    })
  },
  render: function() {
    return(
      <div>
        <Header />
        <div className='primary'>
          <UserSearch/>
          <UserStats leftUser={this.state.leftUser} rightUser={this.state.rightUser} winner={this.state.winner}/>
        </div>
        <Footer />
      </div>
    );
  }
});

ReactDom.render(<App />, document.getElementById('container'));