require 'net/http'
require 'net/https'

def fetch(scheme, host, port, path)

        if port.nil?
                port = 80
        end
	
        puts "Fetching: #{scheme}://#{host}:#{port}#{path}" 
	url = scheme + "://" + host + ":#{port}" + path
	url = URI.parse(url)
	http = Net::HTTP.new(url.host, url.port)
	if scheme == "https"    
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
	result = http.request(Net::HTTP::Get.new(url.request_uri))
	return result
#
# future
# 

# user auth
# request.basic_auth("username", "password")

# form post
# request = Net::HTTP::Post.new(url.request_uri)
# request.set_form_data({"q" => "query", "variable" => "value"})
# result = http.request(request)

end
