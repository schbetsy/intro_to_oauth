class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user  = tweet.user
    p user.username

    tweeter = Twitter::Client.new(oauth_token: user.oauth_token, oauth_token_secret: user.oauth_secret)
    # tweeter.update(tweet.text)
    sleep(3)
    p "This is a 3 second lag"
    p "the tweet said: #{tweet.text}"
  end
end