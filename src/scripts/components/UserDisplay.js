var React = require('react');

var RepoDisplay = require('./RepoDisplay');
var TrophyDisplay = require('./TrophyDisplay');

var UserDisplay = React.createClass({
  renderRepos: function() {
    var user = this.props.user || {};
    return user.repos.map(function(repo, index) {
      return <RepoDisplay repo={repo} key={user.username + '-repo-' + index} />
    });
  },
  render: function() {
    var user = this.props.user || {};
    var isWinner = this.props.winner;
    var classes = isWinner ? 'user-display winner' : 'user-display';
    return (
      <div className={classes}>
        <div className='user-display-header'>
          <img className='avatar' src={'https://avatars.githubusercontent.com/' + user.username} />
          <div className='user-details'>
            <h2 className='username'>
              {user.username}
              <a href={'https://github.com/' + user.username } target="_blank">
                <i className='fa fa-globe'></i>
              </a>
            </h2>
            <div className='user-stats'>
              <div className='total-stars' alt='Total Stars' title='Total Stars'>
                <i className='fa fa-star'></i>
                Total Stars: {user.totalStars}
              </div>
              <div className='total-repos' alt='Total Repos' title='Total Repos'>
                <i className='fa fa-github'></i>
                Total Repos: {user.totalRepos}
              </div>
              <div className='average-stars' alt='Average Stars Per Repo' title='Average Stars Per Repo'>
                <i className='fa fa-line-chart'></i>
                Average Stars: {user.averageStars}
              </div>
            </div>
          </div>

          { isWinner ? <TrophyDisplay username={user.username}/> : '' }
        </div>

        <div className='user-repos-list'>
          {this.renderRepos()}
        </div>
      </div>
    );
  }
});

module.exports = UserDisplay;