require 'net/https'
require 'base64'
require 'uri'
require './config.rb'

Net::HTTP.version_1_2

bearer_token = "#{CONSUMER_KEY}:#{CONSUMER_SECRET}"
encoded_bearer_token = Base64.strict_encode64(bearer_token)

url = URI.parse("https://api.twitter.com/oauth2/token")

https = Net::HTTP.new(url.host, 443)
https.use_ssl = true

https.start do
  header = {}
  header["Authorization"] = "Basic #{encoded_bearer_token}"
  header["Content-Type"] = "application/x-www-form-urlencoded;charset=UTF-8"

  req = Net::HTTP::Post.new(url.path, header)
  req.body = "grant_type=client_credentials"

  resp = https.request(req)
  puts resp.body
end


