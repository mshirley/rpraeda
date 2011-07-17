# improvements
# 
# a bruteforce module would be trivial
#

path = "Login?banner=hello%20world&user=root&password=nasadmin&Login=Login&request_uri=/"
checkfor = "You have successfully authenticated"
successmessage = "SUCCESS : username=admin : password=nasadmin"
failuremessage = "FAILED" 

# we can detect if this job is running in metasploit or stand alone
#  
# needs a wrapper around the http to use metasploit's api instead
if defined?(Metasploit3)
	inmsf = true
else
	inmsf = false
end

if port.nil?
	port = 80
end

# naming convention consistancy fail
host = target

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

puts result.body

if !result.body.include?(checkfor)
	message = successmessage
	if inmsf
		print_status(message)
	else
		puts message
	end
else
	message = failuremessage 
	if inmsf
		print_status(message)
	else
		puts message
	end
end
