require 'socket'
$0 = 'bridge_ssh'
#Process.daemon
$udp_socket = UDPSocket.new
$udp_socket.bind('127.0.0.1', 0)
puts("Existing listeners:\t #{`lsof -nP -i4TCP:25803 | grep LISTEN`}")
$tcp_server = TCPServer.new('127.0.0.1',25803)
puts('listening on:\t 25803')
$local_ip = Socket.ip_address_list.to_s[/ ((?!127)\d\d?\d?\.[0-9]+\.[0-9]+\.[0-9]+)/,1]
puts("local ip:\t #{$local_ip}")
puts("bridge file:\n #{`ls /tmp/bridge_ssh`}")
exit

def udp_send(dat)
  #$udp_socket.send("#{dat}\n", 0, $local_ip, 25803)
  puts("sending #{dat}\n")
end

Thread.abort_on_exception = true
def exit_watch
  def mt() File.mtime("/tmp/bridge_ssh") end
  $mt = mt
  Thread.new do
    c = 0
    loop do
      sleep(5)
      break if($mt!=mt)
      c = c + 1
      next unless c > 10
      udp_send("status:running=YES")
      c = 0
    end
    udp_send("status:running=NO")
    exit
  end
end


exit_watch
loop do
  r = $tcp_server.accept
  h = r.gets.chomp
  pr = Process.spawn(%Q[expect -c "spawn ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no #{h};interact"], :in => r, :out => r, :err => [:child, :out])
  r.close
  Process.detach pr
  udp_send("accepted: #{r.addr}")
  udp_send("new process: #{pr}")
end
