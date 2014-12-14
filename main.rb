=begin
  This part is used as the main function of the whole project
=end

# Require needed files
require_relative 'storage.rb'
require_relative 'extract.rb'
require_relative 'socket_http.rb'

  dbh = DBM.new    # create a instance of DBM (DBM means Database Manipulate)
  initial_keyword ='/s?wd=elong'  # initial keyword
  count = 0      #counter to record how many words have been written
  links = []     # array for storing the url of the keyword
  links << initial_keyword

while count < 100000 do 
    tmp = []
    while links!=[] && count < 100000 do 

      item = links.pop        # pop item from links and use as keyword search
      header, body = send_request(item) # Note: header was used to extract domain
      keywords, titles = extract_target(body)
      # insert title to tbl_title
      titles.each { |title, url|
        if !dbh.is_existed(title,'tbl_title')    # check if the title existed in the table
        dbh.insert_title(title, url)
        end
      }
    # insert keyword to database
      keywords.each { |word,link|
        if !dbh.is_existed(word,'keyword')     # check if the word existed in the table
          dbh.insert_word(word)
          count+=1
          tmp << link
        end
      }
    end
    links = tmp
end





