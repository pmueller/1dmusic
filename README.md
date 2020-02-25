# 1D Music

1D Music allows you to simulate cellular automata and then map the cells to music in 3 different ways.

## Local Setup
```
# requires ruby
bundle install
rake db:create db:migrate
rails server
# app should be available at localhost:3000
```

The latest version is also on heroku at `one-d-music.herokuapp.com`

## Browsers
I've only tested the midi capability on Chrome and Firefox. Might not work on other browsers, especially those that don't support ogg
