# Storing data using active record
require 'active_record'
#change the following to meet your need
ActiveRecord::Base.establish_connection(
  :adapter=>"mysql2",
  :host=>"localhost",
  :database=>"ruby",
  :username=>"root",
  :password=>"11311048"
)
class Keyword < ActiveRecord::Base
end

class Title < ActiveRecord::Base
end