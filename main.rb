#!/usr/bin/ruby

require_relative 'TweetFetcher'


fetcher = TweetFetcher.new
collection = fetcher.fetch("mrgomez77")

collection.each do |tweet|
	puts "Twitter:   #{tweet.text}"
	puts "Url:       #{tweet.uri}"
	puts "Source:    #{tweet.source}"
	puts "Retweets:  #{tweet.retweet_count}"
	
end