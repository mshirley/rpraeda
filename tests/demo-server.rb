require 'socket'

serverversion = "Canon Http Server 2.10"

servername = ""

server = TCPServer.open(80)
loop {	
client = server.accept
puts "got a connection"

request = client.recv(1000)
puts "-- Request was --"
puts request

#if request.include?("/mgmt/gui?P=home&loginUser=admin&loginPassword=password&loginButton=Log+In")
#	client.printf("HTTP/1.1 200 OK\nServer: #{serverversion}\nTitle: #{servername}\nContent-Type: text/html\n\n<html>
#<title>result page</title>
#<body>
#nothing here
#</body>
#</html>
#")
#	client.close
#else

	client.printf("HTTP/1.1 200 OK\nServer: #{serverversion}\nTitle: #{servername}\nContent-Type: text/html\n\n<html>
	<title>HP Color LaserJet CP3505 Printers</title>
	<body>
	nothing here
	</body>
	</html>")
	client.close
}
