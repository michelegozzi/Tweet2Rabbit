require 'twitter'

Bundler.require

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWEET2RABBIT_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWEET2RABBIT_CONSUMER_SECRET"]
  config.access_token        = ENV["TWEET2RABBIT_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWEET2RABBIT_ACCESS_TOKEN_SECRET"]
end

client.update("I'm tweeting with @gem!")