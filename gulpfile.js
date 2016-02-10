'use strict';

var gulp = require('gulp');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');
var reactify = require('reactify');
var less = require('gulp-less');
var concat = require('gulp-concat');
var path = require('path');
var globby = require('globby');
var through = require('through2');
var watch = require('gulp-watch');
var autoprefixer = require('gulp-autoprefixer');

gulp.task('less', function() {
  return gulp.src('./src/less/app.less')
    .pipe(less({
      paths: [ path.join(__dirname, 'src', 'less') ]
    }))
    .pipe(concat('style.css'))
    .pipe(autoprefixer({
      browsers: ['last 2 versions'],
      cascade: false
    }))
    .pipe(gulp.dest('./public/styles'));
});

gulp.task('scripts', function() {
  var bundledStream = through();
  bundledStream
    .pipe(source('app.js'))
    .pipe(buffer())
    .pipe(gulp.dest('./public/scripts/'));

  globby(['./src/scripts/**/*.js']).then(function(entries) {
    var b = browserify({
      entries: entries,
      debug: true,
      transform: ['reactify']
    });
    b.bundle().pipe(bundledStream);
  }).catch(function(err) {
    // ensure any errors from globby are handled
    bundledStream.emit('error', err);
  });

  // finally, we return the stream, so gulp knows when this task is done.
  return bundledStream;

});

gulp.task('watch', ['scripts', 'less'], function() {
  watch('./src/scripts/**/*.js', function() {
    gulp.start('scripts');
  });

  watch('./src/less/**/*.less', function() {
    gulp.start('less');
  });
})