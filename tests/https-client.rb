require 'net/http'
require 'net/https'


http = Net::HTTP.new("localhost",443)
req = Net::HTTP::Get.new("/")
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
#req.basic_auth username, password
response = http.request(req)
puts response.body
