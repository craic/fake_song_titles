#!/usr/bin/env ruby

# fake_song_title_app.rb

# Copyright 2011  Robert Jones  (jones@craic.com)   Craic Computing LLC
# This code and associated data files are distributed freely under the terms of the MIT license

# Initially this is a Fake Captain Beefheart Song Title Generator
# Based on a comment of Gideon Coe on BBC 6Music in November 2011 regarding the odd song titles
# of Captain Beefheart (Don Van Vliet). Gideon commented that there should be a Beefheart song title
# generator ... and so now there is ...


require 'erb'

$:.unshift File.join(File.dirname(__FILE__))

#-----------------------------------------------------------------


def load_words(filename)
  words = Hash.new
  open(filename, 'rb').each_line do |line|
    next if line =~ /^#/ or line =~ /^\s*$/
    line.chomp!
    words[line.downcase] = 1
  end
  words.keys.sort
end


def pick_two_nouns_and_linkage(nouns, linkages)
  word0 = nouns[rand(nouns.length)]
  word1 = nouns[rand(nouns.length)]
  link = linkages[rand(linkages.length)]
  "#{word0} #{link} #{word1}"
end

def pick_two_nouns(nouns)
  word0 = nouns[rand(nouns.length)]
  word1 = nouns[rand(nouns.length)]
  "#{word0} #{word1}"
end

def pick_adjective_and_noun(nouns, adjectives)
  word0 = nouns[rand(nouns.length)]
  adj0 = adjectives[rand(adjectives.length)]
  "#{adj0} #{word0}"
end

def pick_two_nouns_adjective_and_linkage(nouns, adjectives, linkages)
  word0 = nouns[rand(nouns.length)]
  word1 = nouns[rand(nouns.length)]
  adj0 = adjectives[rand(adjectives.length)]
  link = linkages[rand(linkages.length)]
  "#{adj0} #{word0} #{link} #{word1}"
end

def pick_two_nouns_and_verb(nouns, verbs)
  word0 = nouns[rand(nouns.length)]
  word1 = nouns[rand(nouns.length)]
  verb = verbs[rand(verbs.length)]
  "#{word0} #{verb} #{word1}"
end

# MAIN -----------------------------------------------------------------


class FakeSongTitlesApp < Sinatra::Base

  set :root, File.dirname(__FILE__)

  set :static, true

  nouns_file = File.join(File.dirname(__FILE__), 'data', 'nouns.txt')
  verbs_file = File.join(File.dirname(__FILE__), 'data', 'verbs.txt')
  adjectives_file = File.join(File.dirname(__FILE__), 'data', 'adjectives.txt')
  linkages_file = File.join(File.dirname(__FILE__), 'data', 'linkages.txt')

  nouns = load_words(nouns_file)
  verbs = load_words(verbs_file)
  adjectives = load_words(adjectives_file)
  linkages = load_words(linkages_file)

  get '/' do
    n_titles = 1
    @titles = Array.new
    (0...n_titles).each do |i|
      @titles << pick_two_nouns_and_linkage(nouns, linkages)
      @titles << pick_two_nouns(nouns)
      @titles << pick_adjective_and_noun(nouns, adjectives)
      @titles << pick_two_nouns_adjective_and_linkage(nouns, adjectives, linkages)
      @titles << pick_two_nouns_and_verb(nouns, verbs)
    end
    erb :index
  end

  get '/about' do
    erb :about
  end

end
