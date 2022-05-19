require 'socket'
puts("Source file a: #{`ls "$(echo ~/*/*/u*/*/bridge_ssh.xml)"`}")
puts("Source file b: #{`ls "$(echo ~/*/*/*/u*/*/bridge_ssh.xml)"`}")
puts("Source file c: #{`ls "$(echo ~/*/*/*/*/u*/*/bridge_ssh.xml)"`}")
puts("Existing listeners: #{`lsof -nP -i4TCP:25803 | grep LISTEN`}")
puts("Existing process: #{`ps ax | grep [b]ash_ssh`}")
puts("bridge file: #{`ls /tmp/bridge_ssh`}")
puts("expect binary: #{`which expect`}")
$local_ip = Socket.ip_address_list.to_s[/ ((?!127)\d\d?\d?\.[0-9]+\.[0-9]+\.[0-9]+)/,1]
puts("local ip: #{$local_ip}")
$tcp_server = TCPServer.new('127.0.0.1',25803)
puts("listening on: 25803")
puts("Done")
