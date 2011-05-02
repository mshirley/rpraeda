require 'socket'

serverversion = "Canon Http Server 2.10"

servername = ""

server = TCPServer.open(1234)
loop {	
client = server.accept
client.printf("HTTP/1.1 200 OK\nServer: #{serverversion}\nTitle: #{servername}\nContent-Type: text/html\n\n<html>
<title>HP Color LaserJet CP3505 Printers</title>
<body>
nothing here
</body>
</html>")
client.close
}
