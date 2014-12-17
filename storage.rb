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
    puts "Inserting data \e[31m #{word} \e[0m into table `keyword`..."
    sql = "INSERT INTO keyword(word) VALUES ( ? )"
    stmt = @connection.prepare(sql)
    stmt.execute(word)
    stmt.close
  end

  # Insert the title and url into database
  # @parma title, a string
  # @parma url, a string

  def insert_title(title, domain)
    puts "Inserting title  \e[31m #{title} \e[32m #{domain} \e[0m  into table `tbl_title`..."
    sql = "INSERT INTO tbl_title(title,domain,count) VALUES ( ?,?,1 )"
    stmt = @connection.prepare(sql)
    stmt.execute(title,domain)
    stmt.close
  end

  #Update the table's count 
  # @parma table, s string
  # @parma field, s string

  def update_table(table, field, title_value)
    sql = "UPDATE #{table} SET #{field}=#{field}+1 WHERE title = ?"
    stmt = @connection.prepare(sql)
    stmt.execute(title_value)
    stmt.close
  end

  # Check if the item exists in database
  # @parma item, s string
  # @parma table, s string
  # @return boolean

  def is_existed(item, table);
    if table ==='keyword'
      sql = 'SELECT word FROM keyword WHERE word = ?'
    else
      sql = 'SELECT title FROM tbl_title WHERE title = ?'
    end
    stmt = @connection.prepare(sql)
    stmt.execute(item)
    result = stmt.fetch
    stmt.close
    return result!=nil
  end

end