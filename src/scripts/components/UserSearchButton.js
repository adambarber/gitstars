var React = require('react');

var UserSearchButton = React.createClass({
  render: function() {
    return(
      <div className='submit-button-wrapper'>
        <button type='submit' className='user-search-button' disabled={!this.props.active || this.props.submitted}>Fight!</button>
        {this.props.submitted ? <i className="fa fa-circle-o-notch fa-spin loading-spinner"></i> : ''}
      </div>
    )
  }
});

module.exports = UserSearchButton;