=begin
    This Section aims at scrapy html file from a given url.
    Note that the http implementation is based on socket.
=end

require 'socket'               # Get sockets from stdlib
require 'thread'               # Get some thread api
# Send http request to baidu using socket and received response
#   @parma string, the path of a http request
#   @Return string, the response data
def fetch( path='/' )

    host = 'www.baidu.com'     # The domain of baidu, my target website
    port = 80                  # Default HTTP port

    # This is the HTTP request we send to fetch a file
    request = "GET #{path} HTTP/1.0\r\n"+"Connection:keep-alive\r\n\r\n"
    response=''                # The response
    puts 'requesting...'

    socket = TCPSocket.open(host,port)  # Connect to server
    socket.puts(request)                # Send request 

    threads = []                        # thread array

    # @FIX Me : In this part I want to use five threads to receive data
    # But it always results in block, I could not fix this bug so far.

    mutex = Mutex.new
    # Read complete response with five threads
    5.times {
      threads << Thread.new {
        mutex.synchronize do
          while line = socket.gets
            response += line
          end
        end
        }
    }
    threads.each { |t| t.join }

  ''' uncomment this to use single thread
    while line = socket.gets
      response += line
    end
  '''

    puts 'Receiving response...'
    # Split response at first blank line into headers and body
    header, body = response.split("\r\n\r\n", 2)
    socket.close      #close socket
    return header, body
end

# extract domain from headers 
#   @parma header, a string 
#   @Return string, the domain
def get_domain( header )
  header_content = header.split("\r\n")
  # traverse the header and find the location item   
  header_content.each { |item|
      if item.start_with?('Location')
        domain = item.split("/")[2]
        return domain
      end
  }
  return nil
end

