## Class that permits to send automatic message to twitter accounts
## I do not know if it needs several application configuration
class TwitterSender
  require 'twitter'

  # Application credentials
  APPLICATION_KEY = "0FZSAem7t8EPtk5qp3vWYgJhE"
  APPLICATION_SECRET = "0PZAXFMk6oJc9ccwIVoi7Zc0NRvfc4vysVc2PKRfn5RkkBi3zI"

  #TODO Implement a counting method to check the size of the tweet
  #TODO Implement a callback to see if the tweet has been correctly updated on send_tweet

  #TODO Implement function to follow tweets containing certain tags
  #TODO Implement functions to follow the people emeting the tweets

  # Initialize a Twitter Sender object to handle the client
  def initialize(access_token, access_token_secret)
    @access_token = access_token
    @access_token_secret = access_token_secret
    @client = TwitterSender.client(access_token, access_token_secret)
  end
  
  def client
    return @client
  end

  # Method accessible from the outside
  def send_tweet(message, url, tags)
    tweet = TwitterSender.convert_message_in_tweet(message, url, tags)
    self.sender(tweet)
  end

  # Test Method
  def test
    tweet = TwitterSender.convert_message_in_tweet("Bonjour le test", "http://les-conjugaisons.com", ["test", "louis"])
    self.sender(tweet)
  end

  # Methods that send the tweet
  def sender(tweet)
    client = self.client
    client.update(tweet)
  end

  private

  # Initialize a client twitter object
  def self.client(access_token, access_token_secret)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = APPLICATION_KEY
      config.consumer_secret     = APPLICATION_SECRET
      config.access_token        = access_token
      config.access_token_secret = access_token_secret
    end
    return client
  end

  # Convert the message in the twitter form
  def self.convert_message_in_tweet(message, url, tags)
    message= message.to_s
    url = url.to_s
    tags_array = []
    tags.each do |t|
      s = "#" + t.to_s.strip
      tags_array << s
    end

    tags_string = tags_array.join(' ')
    tweet = message + " " + url + " " + tags_string
    return tweet
  end

end