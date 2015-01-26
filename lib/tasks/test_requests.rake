# Hellocoton crawler.Mode
task :test_message => :environment do
  require 'typhoeus'
  require 'open-uri'
  require 'uri'
  
request = Typhoeus::Request.new(
  "http://localhost:3000/api/newmessage",
  method: :post,
  body: "this is a request body",
  params: { service_token: "a7fbfb2e47ecac20539d8141cffd34ee", message: {content: "Test depuis l'api", url: "http://rebble.it", tags: "louis, ruby, api"} },
  headers: { Accept: "text/html" }
)
request.run

end


task :test_message_web => :environment do
  require 'typhoeus'
  require 'open-uri'
  require 'uri'
  
request = Typhoeus::Request.new(
  "http://socialpresence.herokuapp.com/api/newmessage",
  method: :post,
  body: "this is a request body",
  params: { service_token: "a933b6adc740d21794e459a3c2666d91", message: {content: "API social presence", url: "http://rebble.it", tags: "ruby, api, socialpresence"} },
  headers: { Accept: "text/html" }
)
request.run

end


