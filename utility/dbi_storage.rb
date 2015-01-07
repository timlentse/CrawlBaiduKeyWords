
# This is a class for database's curd manipulation  using dbi libs

require "dbi"

class DBIM

  # Connect to the MySQL server
  # Change the following to meet your need if necessary
  def initialize
    @connection = DBI.connect("DBI:Mysql:ruby:localhost","root", "11311048")
  end

  # Insert the words into database
  # @parma word, a string

  def insert_word(word)
     sth = @connection.prepare("INSERT INTO keyword(word) VALUES(?)")
     sth.execute(word)
     sth.finish
  end

  # Insert title and domain into database
  # @parma title, a string
  # @parma domain, a string

  def insert_title(title, domain)
    sth = @connection.prepare("INSERT INTO tbl_title(title, domain, count) VALUES(?, ?, 1)")
    sth.execute(title, domain)
    sth.finish
  end

  # Checks if the item exists in database
  # @parma item, a string
  # @parma table, a string
  # @return boolean
  def is_existed(item, table)
    field = table==='tbl_title'? 'title':'word'
    sql = "SELECT #{field} FROM #{table} WHERE #{field}='#{item}'"
    sth = @connection.prepare(sql)
    sth.execute()
    result = sth.rows
    if result!=nil
      sth.finish
      return true
    else
      sth.finish
      return false
    end
  end

  # Update the table's count 
  # @parma table, s string
  # @parma field, s string

  def update_table(table, field, title_value)
    sql = "UPDATE #{table} SET #{field}=#{field}+1 WHERE title = ?"
    stmt = @connection.prepare(sql)
    stmt.execute(title_value)
    stmt.finish
  end

   # Disconnect from server
  def disconnect
     @connection.disconnect if @connection
  end

end