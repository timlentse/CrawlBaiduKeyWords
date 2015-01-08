## CrawlBaiduKeyWords

This repo is just a little demo in ruby which is used for Crawling baidu keywords and the top 10 titles
appending with url recursively and stored the data in database(`mysql`).To save the result, I use two table,
one stores keyword and the other stores top 10 titles and urls.


### Installation

Add this line to your application's Gemfile:

```ruby
gem 'CrawlBaiduKeyWords'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install CrawlBaiduKeyWords

### Usage

##### 1. Create database and two tables
```sql  
    /*create database */     
    CREATE DATABASE IF NOT EXISTS ruby 
    
    /*create table keywords */  
    CREATE TABLE IF NOT EXISTS `keywords` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `word` char(255) DEFAULT NULL,
      `updated_at` datetime NOT NULL,
      `created_at` datetime NOT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
    
    /*create table titles */  
      CREATE TABLE IF NOT EXISTS `titles` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `title` text,
        `domain` char(255) DEFAULT NULL,
        `updated_at` datetime NOT NULL,
        `created_at` datetime NOT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
```

#####2. You may install nokogiri by the following command in shell
```python
    sudo gem install nokogiri
```
###Bug
However, There still some bugs in this demo. Any suggestion will be welcome. 

* Mysql connection sometimes will be closed due to the issue of mysql2   
* Speed needs to be improved   

## Contributing

1. Fork it ( https://github.com/[my-github-username]/CrawlBaiduKeyWords/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
