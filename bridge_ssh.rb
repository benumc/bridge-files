require 'socket'
puts("Source file: #{`ls "$(echo ~/*/*/*/u*/*/bridge_ssh.xml)"`}")
puts("Existing listeners:\t #{`lsof -nP -i4TCP:25803 | grep LISTEN`}")
$tcp_server = TCPServer.new('127.0.0.1',25803)
puts("listening on:\t 25803")
$local_ip = Socket.ip_address_list.to_s[/ ((?!127)\d\d?\d?\.[0-9]+\.[0-9]+\.[0-9]+)/,1]
puts("local ip:\t #{$local_ip}")
puts("bridge file:\n #{`ls /tmp/bridge_ssh`}")
puts("Done")
