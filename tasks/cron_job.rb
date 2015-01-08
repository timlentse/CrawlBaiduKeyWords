# Require needed files
require 'BaiduKeyWords'
Utility_Dir = File.expand_path(File.dirname(__FILE__))
require "#{Utility_Dir}/../utility/db"

desc "The is the crawl job of the gem"
  task :crawl_job do
    Initial_Search ='http://www.baidu.com/s?wd=elong'  # initial keyword, you can change it
    counter = 0      
    query = Queue.new # Array stores the the keywords pending to be queried
    query.push(Initial_Search)
    MAX = 100000
    tbl_title = Queue.new
    tbl_keyword = Queue.new
    Thread_Num = 10

  crawlers = (0...Thread_Num).map do
    Thread.new do
      while counter < MAX do 
          tmp = []
          while !query.empty? && counter < MAX do
            sleep(0.1) 
            item = query.pop        # pop item from query and used as keyword search
            begin
            body, domain = BaiduKeyWords.fetch(item)
            keywords, titles = BaiduKeyWords.extract_target(body)
            # Insert title and domain into tbl_title
            titles.each { |iter|
              row = {}
              if !Title.exists?(title: iter[:title])
                row[:title] = iter[:title]
                body, domain = BaiduKeyWords.fetch(iter[:url])
                row[:domain] = domain 
                tbl_title.push(row)
              end
            }

          # Insert keyword into database
            keywords.each { |word|
              if !Keyword.exists?(word: word[:word]) 
                tbl_keyword.push(:word=>word[:word])
                  counter+=1
                  tmp.push("http://www.baidu.com#{word[:url]}")
              end
            }
            rescue => e
              p e
              sleep(2)
              next
            end
          end
        query = tmp
        end
      end
    end

    writer = Thread.new do
      # wait for workers
      sleep(Thread_Num*0.2+3)
      puts "writing..."
      while true
        begin
          # Save data to mysql 
          Keyword.new(tbl_keyword.pop).save
          Title.new(tbl_title.pop).save
          # Adaptive writing rate
          sleep(1.0/(tbl_keyword.length+1))
        rescue => e
          p e
          # TODO : Add error handling
        end
      end
    end

# join the thread
crawlers.each{|thr| thr.join}
#crawler.join
writer.join
end



