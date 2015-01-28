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
  
  # REturn the client to call twitter methods
  def client
    return @client
  end

  # Method accessible from the outside
  def send_tweet(message, url, tags, person = "")
    tweet = TwitterSender.convert_message_in_tweet(message, url, tags, person)
    self.sender(tweet)
    return true
  end
  
  # Return array of tweets. Tags in an array of string
  def search_tweets(tags)
    search = TwitterSender.convert_tags_in_search(tags)
    tweets = []
    self.client.search(search, :result_type => "recent", :lang => "fr").take(10).collect do |tweet|
      puts "#{tweet.user.screen_name}: #{tweet.text}"
      tweets << tweet
    end
    return tweets
  end

  # Follow sender of interesting tweets. Tags is an array of keyword
  def follow_tweet_sender(tags)
    tweets = self.search_tweets(tags)
    to_follow = tweets.map{|t| t.user.screen_name}
    self.follow_people(to_follow)
  end

  # Follow array of screen names
  def follow_people(users)
    client = self.client
    users.each do |user|
      client.follow(user)
    end
  end

  # Methods that send the tweet
  def sender(tweet)
    client = self.client
    client.update(tweet)
  end
  
   # Test Method for sending a message
  def test_tweet
    tweet = TwitterSender.convert_message_in_tweet("Bonjour le test", "http://les-conjugaisons.com", ["test", "louis"], "nadvence")
    self.sender(tweet)
  end

  # test of search tweets
  def test_topics
    tags = ["conjugaison", "grammaire"]
    search = TwitterSender.convert_tags_in_search(tags)
    to_follow = []
    puts search.to_s
    self.client.search(search, :result_type => "recent", :lang => "fr").take(10).collect do |tweet|
      puts "#{tweet.user.screen_name}: #{tweet.text}"
      to_follow << tweet.user.screen_name
    end
    self.follow_people(to_follow)
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

  def self.convert_tags_in_search(tags)
    search = ""
    search_tags = []
    tags.each do |tag|
      search_tags << "#" + tag.strip.downcase.to_s
    end
    search = search_tags.join(' OR ')
    search = search + " -rt"
    return search
  end

  # Convert the message in the twitter form
  def self.convert_message_in_tweet(message, url, tags, person = "")
    message= message.to_s
    url = url.to_s
    tags_array = []
    tags.each do |t|
      s = "#" + t.to_s.strip
      tags_array << s
    end
    tags_string = tags_array.join(' ')
    if !person.to_s.empty?
      person = " @" + person.to_s
    end
    tweet = message + " " + url + " " + tags_string + person
    return tweet
  end

end