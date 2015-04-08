#!/usr/bin/ruby

require 'twitter'

class TweetFetcher

	def initialize
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV["TWEET2RABBIT_CONSUMER_KEY"]
			config.consumer_secret     = ENV["TWEET2RABBIT_CONSUMER_SECRET"]
			config.access_token        = ENV["TWEET2RABBIT_ACCESS_TOKEN"]
			config.access_token_secret = ENV["TWEET2RABBIT_ACCESS_TOKEN_SECRET"]
		end
	end

	def collect_with_max_id(collection=[], max_id=nil, &block)
		response = yield(max_id)
		collection += response
		response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
	end

	#def client.get_all_tweets(user)
	#	collect_with_max_id do |max_id|
	#		options = {count: 200, include_rts: true}
	#		options[:max_id] = max_id unless max_id.nil?
	#		user_timeline(user, options)
	#	end
	#end

	def fetch(user)
		@client.get_all_tweets(user)
	end
end

# Add an instance method named m to class c with body b
def add_method(c, m, &b)
	c.class_eval {
		define_method(m, &b)
	}
end

add_method(Twitter::REST::Client, :get_all_tweets) do |user|
	puts "#{user}"
	collect_with_max_id do |max_id|
		options = {count: 200, include_rts: true}
		options[:max_id] = max_id unless max_id.nil?
		user_timeline(user, options)
	end
end