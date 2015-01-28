## Class that permits to send automatic message to social presence
## I do not know if it needs several application configuration
class SocialPresence
  require 'typhoeus'
  require 'open-uri'
  require 'uri'
  
  SERVICE_TOKEN = "a933b6adc740d21794e459a3c2666d91"
  
  # All strings. Tags separated by commas.
  def self.send_message(content, url, tags, person)
    content = content.to_s
    url = url.to_s
    tags = tags.to_s
    person = person.to_s
    request = Typhoeus::Request.new(
      "http://socialpresence.herokuapp.com//api/newmessage",
      method: :post,
      body: "this is a request body",
      params: { service_token: SERVICE_TOKEN, message: {content: content, url: url, tags: tags, person: person} },
      headers: { Accept: "text/html" }
    )
    request.run
  end

end