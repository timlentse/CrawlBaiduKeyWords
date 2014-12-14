=begin
  This part I write two functions to finish the extracted jobs.
    The function named extract_target is used to process the doccument 
    and return two hash tables (titles=>urls pairs) and (keywords=>url pair)
    The function named get_text aims at getting the text of a node
Notes:
    There is no built-in HTML parser (yet),so i grab Nokogiri instead.
=end

require 'nokogiri'

# Extract related Keywords and top 10 titles from document
#  @parma file, the taget document
#  @Return Keywords and titles（hash table)

def extract_target(file)

  puts 'extracting...'
  doc = Nokogiri::HTML(file)
  rs_nodes = doc.css("#rs").xpath("//table/tr/th/a")
  top_ten_nodes = doc.css("#content_right").xpath("//h3/a")

  top_ten_titles = Hash.new
  related_words = Hash.new

  for item in top_ten_nodes
    link =  item.xpath('./@href').first.value
    top_ten_titles[get_text(item)] = link
  end

  for word in rs_nodes
    related_words[get_text(word)] = word.xpath("./@href")
  end
  return related_words, top_ten_titles
end


# Remove all tags and reserve the text of the given node
#  @parma node_item, the node element
#  @Return string 

def get_text(node_item)
  title = node_item.xpath('.//text()').map(&:text).join(' ')
  return title
end
