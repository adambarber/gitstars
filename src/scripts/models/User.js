var User = function User(opts) {
  this.username = opts.username;
  this.repos = opts.repos;
  this.totalStars = opts.total_stars;
  this.averageStars = opts.average_stars;
  this.totalRepos = opts.total_repos;
}

module.exports = User;