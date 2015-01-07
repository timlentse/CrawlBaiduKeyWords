require "BaiduKeyWords/version"
require 'nokogiri'
require 'net/http'
require 'uri'
module BaiduKeyWords

  def self.fetch(uri_str, limit = 10)
    puts uri_str
    # You should choose a better exception.
    raise ArgumentError, 'too many HTTP redirects' if limit == 0
    begin
    @response = Net::HTTP.get_response(URI(uri_str))
    rescue =>e
      p e
      return nil, nil
    end
    case @response
    when Net::HTTPSuccess then
      return @response.body, self.domain(uri_str)
    when Net::HTTPRedirection then
      location = @response['location']
      fetch(location, limit - 1)
    else
      @response.value
    end
  end

  def self.domain(url)
    @domain = URI(url).host
    @domain
  end

   # Extract related Keywords and top 10 titles from document
    #  @parma file, the taget document
    #  @Return Keywords and titles（hash table)

    def self.extract_target(file)

      puts 'extracting...'
      doc = Nokogiri::HTML file
      rs_nodes = doc.css("#rs").xpath("//table/tr/th/a")
      top_ten_nodes = doc.css("#content_right").xpath("//h3/a")

      top_ten_titles = []
      related_words = []

      top_ten_nodes.each { |item|
        link =  item.xpath('./@href').first.value
        elem = {}
        elem[:url] = link
        elem[:title] = self.get_text(item)   
        top_ten_titles.push(elem)
     }

      rs_nodes.each { |word|
        elem = {}
        elem[:word] = word.text
        elem[:url] = word.xpath("./@href").first.value
        related_words.push(elem)
      }

      return related_words, top_ten_titles
    end

    # Remove all tags and reserve the text of the given node
    #  @parma node_item, the node element
    #  @Return string 

    def self.get_text(node_item)
      title = node_item.xpath('.//text()').map(&:text).join(' ')
      return title
    end

end
