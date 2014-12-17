=begin
  This part is used as the main function of the whole project
=end

# Require needed files
require './storage.rb'
require './extract.rb'
require './netcrawl.rb'

  dbh = DBM.new    # Create an instance of DBM (DBM means Database Manipulate)
  initial_keyword ='/s?wd=elong'  # initial keyword, you can change this
  count = 0      #counter to record how many keywords have been written to table
  query =[initial_keyword] # Array stores the the keywords pending to be queried

while count < 100000 do 
    tmp = []
    while query!=[] && count < 100000 do 
      item = query.pop        # pop item from query and used as keyword search
      uri = "http://www.baidu.com#{item}"
      begin
      domain, body = fetch(uri) # Note: The domain was extracted in fetch step
      keywords, titles = extract_target(body)
      
      # Insert title and domain into tbl_title
      titles.each { |title, url|
        if !dbh.is_existed(title, 'tbl_title') # check if the title existed in the table
          domain, body = fetch(url)
          dbh.insert_title(title, domain)
        else
            dbh.update_table('tbl_title', 'count', title)
        end
      }

    # Insert keyword into database
      keywords.each { |word,link|
        if !dbh.is_existed(word,'keyword')# check if the word existed in the table
          dbh.insert_word(word)
          count+=1
          tmp << link
        end
      }
      rescue
        next
      end
    end
    query = tmp
end





