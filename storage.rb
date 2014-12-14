# The class for manipulating database 
require "mysql"

class DBM

  # Initialize a connection to Mysql with passwd and username
  # Change the following to meet your need

  def initialize
    @connection = Mysql::new("localhost", "root", "11311048", "Keywords_ruby")
  end

  # Insert the words into database
  # @parma word, a string

  def insert_word(word)
    puts 'inserting data--'+word+' into table keyword...'
    sql = "INSERT INTO keyword(word) VALUES ( ? )"
    stmt = @connection.prepare(sql)
    stmt.execute(word)
    stmt.close
  end

  # Insert the title and url into database
  # @parma title, a string
  # @parma url, a string

  def insert_title(title,url)
    puts 'inserting data--'+title+' into table tbl_title...'
    sql = "INSERT INTO tbl_title(title,domain) VALUES ( ?,? )"
    stmt = @connection.prepare(sql)
    stmt.execute(title,url)
    stmt.close
  end

  # Check if the word exists in database
  # @parma word, s string
  # @parma table, s string
  # @return boolean

  def is_existed(word,table);
    if table ==='keyword'
      sql = 'SELECT word FROM keyword WHERE word = ?'
    else
      sql = 'SELECT title FROM tbl_title WHERE title = ?'
    end
    stmt = @connection.prepare(sql)
    stmt.execute(word)
    result = stmt.fetch
    stmt.close
    return result!=nil
  end

end