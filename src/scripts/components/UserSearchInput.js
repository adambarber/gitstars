var React = require('react');

var UserSearchInput = React.createClass({
  clearUsername: function() {
    var position = this.props.position;
    this.setState({ value: '' });
    this.props.onUsernameChange(position, '');
  },
  onChange: function() {
    var username = this.refs.username.value;
    var position = this.props.position;
    this.setState({ value: username });
    this.props.onUsernameChange(position, username);
  },
  renderClearButton: function() {
    return(
      <div className='clear-user-search-input' onClick={this.clearUsername}>
        <i className='fa fa-close'></i>
      </div>);
  },
  getInitialState: function() {
    return {
      value: ''
    };
  },
  render: function() {
    var inputValue = this.state.value;
    return(
      <div className={'user-search-input-container ' + this.props.className}>
        <input type='text' ref='username' placeholder='Github Username' className='user-search-input' onChange={this.onChange} value={this.state.value}/>
        {inputValue.length > 0 ? this.renderClearButton() : ''}
      </div>
    )
  }
});

module.exports = UserSearchInput;