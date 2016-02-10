var React = require('react');

var UserDisplay = require('./UserDisplay');

var UserStats = React.createClass({
  render: function() {
    return(
      <div className='user-stats-wrapper'>
        {this.props.leftUser ? <UserDisplay user={this.props.leftUser} winner={this.props.winner === 'left'} /> : '' }
        {this.props.rightUser ? <UserDisplay user={this.props.rightUser} winner={this.props.winner === 'right'}/> : '' }
      </div>
    )
  }
});

module.exports = UserStats;