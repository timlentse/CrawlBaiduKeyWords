=begin
    This Section aims at fetching html file from a given uri.
    To simplify the job, I use the net/http libs
=end

require 'net/http'

# Fetch the html using net::http
#  @parma uri_str, a string
#  @Return strings, domain and body

def fetch(uri_str)
  puts 'Fetching...'
  response = Net::HTTP.get_response(URI(uri_str))
  case response
  when Net::HTTPSuccess then
    return get_domain(uri_str), response.body
  when Net::HTTPRedirection then
    location = response['location']
    return get_domain(location), nil
  else
    return nil, response.value
  end
end

# Get the domain of the uri
#  @parma uri_str, a string
#  @Return domain, a string

def get_domain(uri_str)
    puts 'Encoding...'
    URI.parse(uri_str).host
end
