
require "dbi"

class DBIM
  # connect to the MySQL server
  def initialize
    @connection = DBI.connect("DBI:Mysql:Keywords_ruby:localhost","root", "11311048")
  end

  def insert_word(word)
     sth = @connection.prepare("insert into table keyword(word) values(?)")
     sth.execute(word)
     sth.finish
  end

  def insert_title(title, domain)
    sth = @connection.prepare("insert into table tbl_title(title, domain) values(?,?)")
    sth.execute(title, domain)
    sth.finish
  end

  def is_exists(item, table)
    field = table==='tbl_title'? 'title':'keyword'
    sql = "select #{field} from #{table} where #{field}=#{item}"
    sth = @connection.prepare(sql)
    sth.execute()
    result = sth.fetch
    if result !=nil
      sth.finish
      return true
    else
      sth.finish
      return false
    end
  end

   # disconnect from server
  def disconnect
     @connection.disconnect if @connection
  end
end