#!/usr/bin/env ruby

# fake_song_title_app.rb

# Copyright 2011  Robert Jones  (jones@craic.com)   Craic Computing LLC
# This code and associated data files are distributed freely under the terms of the MIT license

# Initially this is a Fake Captain Beefheart Song Title Generator
# Based on a comment of Gideon Coe on BBC 6Music in November 2011 regarding the odd song titles
# of Captain Beefheart (Don Van Vleet). Gideon commented that there should be a Beefheart song title
# generator ... and so now there is ...

def load_words(filename)
  words = Hash.new
  open(filename, 'rb').each_line do |line|
    next if line =~ /^#/ or line =~ /^\s*$/
    line.chomp!
    words[line.downcase] = 1
  end
  words.keys.sort
end

#-----------------------------------------------------------------

nouns_file = File.join(File.dirname(__FILE__), 'data', 'nouns.txt')
verbs_file = File.join(File.dirname(__FILE__), 'data', 'verbs.txt')
adjectives_file = File.join(File.dirname(__FILE__), 'data', 'adjectives.txt')
linkages_file = File.join(File.dirname(__FILE__), 'data', 'linkages.txt')

nouns = load_words(nouns_file)
verbs = load_words(verbs_file)
adjectives = load_words(adjectives_file)
linkages = load_words(linkages_file)

abort "Usage: #{$0} <n titles>" unless ARGV.length == 1

n_titles = ARGV[0].to_i
abort "ERROR: N titles must be at least 1" if n_titles < 1


(0...n_titles).each do |i|
  # pick 2 nouns and a linkage
  word0 = nouns[rand(nouns.length)]
  word1 = nouns[rand(nouns.length)]
  link = linkages[rand(linkages.length)]
  puts "#{word0} #{link} #{word1}"
  
  word0 = nouns[rand(nouns.length)]
  word1 = nouns[rand(nouns.length)]
  puts "#{word0} #{word1}"

  
  word0 = nouns[rand(nouns.length)]
  adj0 = adjectives[rand(adjectives.length)]
  puts "#{adj0} #{word0}"


  adj0 = adjectives[rand(adjectives.length)]
  word0 = nouns[rand(nouns.length)]
  word1 = nouns[rand(nouns.length)]
  link = linkages[rand(linkages.length)]
  puts "#{adj0} #{word0} #{link} #{word1}"

  word0 = nouns[rand(nouns.length)]
  word1 = nouns[rand(nouns.length)]
  verb = verbs[rand(verbs.length)]
  puts "#{word0} #{verb} #{word1}"
  
end
