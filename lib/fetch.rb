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
	http.read_timeout = 500
	if scheme == "https"    
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end

	begin
		result = Timeout::timeout(10) { http.request(Net::HTTP::Get.new(url.request_uri)) }
	rescue Timeout::Error
		result = "ERROR: Fetch timeout"
	rescue Errno::ECONNREFUSED
		result = "ERROR: Connection refused"
	else
	end

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
