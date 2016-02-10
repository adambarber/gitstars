var React = require('react');

var RepoDisplay = React.createClass({
  render: function() {
    var repo = this.props.repo || {};
    var classes = 'repo-display ' + repo.language;
    return (
      <div className={classes}>
        <h3 className='repo-link'>
          <a href={repo.html_url} target="_blank">{repo.name}</a>
        </h3>
        <div className='repo-content'>
          <div className='repo-full-name'>{repo.full_name}</div>
          <div className='repo-description'>{repo.description}</div>

          <div className='repo-stargazers-count'>
            <i className="fa fa-star"></i>
            {repo.stargazers_count}
          </div>
        </div>
      </div>
    );
  }
});

module.exports = RepoDisplay;