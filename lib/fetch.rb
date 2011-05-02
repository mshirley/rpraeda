require 'net/http'
require 'net/https'

def fetch(scheme, host, port, path)

        if port.nil?
                port = 80
        end

        #puts "Fetching: #{prefix}#{url}:#{port}" 
	#uri = URI.parse(scheme prefix + url + ":#{port}")
	url = scheme + "://" + host + ":#{port}" + path
	url = URI.parse(url)
	result = Net::HTTP.start(url.host, url.port) { |http|
		http.get(path)
	}
	return result
        #response = Net::HTTP.get_print URI.parse(prefix + url + ":#{port}")
	#return response
end
