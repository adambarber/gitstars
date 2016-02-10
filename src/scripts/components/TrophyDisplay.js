var React = require('react');

var TrophyDisplay = React.createClass({
  render: function() {
    var altText = this.props.username + ' is the winner';
    return (
      <div className='trophy-display' alt={altText} title={altText}>
        <div className='trophy-display-inner'>
          <i className='fa fa-trophy'></i>
        </div>
      </div>
    );
  }
});

module.exports = TrophyDisplay;