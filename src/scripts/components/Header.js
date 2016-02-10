var React = require('react');

var Header = React.createClass({
  render: function() {
    return(
      <header>
        <h1>GitStars</h1>
        <h3>Pit your favorite Githubbers against each other in the battle of the stars!</h3>
      </header>
    )
  }
});

module.exports = Header;