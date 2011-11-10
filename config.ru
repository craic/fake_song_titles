# Run this with 'rackup -p 4567'

require 'bundler'
Bundler.require

require 'sinatra'

require './fake_song_titles_app.rb'

run FakeSongTitlesApp.new
