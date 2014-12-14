CrawlBaiduKeyWords
==================
#### About the Repo    
This repo is just a little demo in ruby which is used for Crawling baidu keywords and the top 10 titles
appending with url recursively and stored the data in database(`mysql`).To save the result, I use two table,
one stores keyword and the other stores top 10 titles and urls.

#### Requirements

* [Ruby](https://www.ruby-lang.org) development enviroment 
* Mysql(if other database you should write your own storage module)
* You should konw some basic konwledge of Crawl a website.
*  That's all      
`Note:`
Your machine should had `nokogiri` installed since it was needed in file `extract.rb`     

####`Here is my machine equipment:`   
<pre>
1. Xubuntu14.04 [x86_64-linux]
2. Ruby 1.9.3
3. Mysql 5.5.40
</pre>
### What is the logic of the repo

#### 1. Create database and two tables
```sql  
    /*create database */     
    create database keywords_ruby 
    
    /*create table keyword */  
    CREATE TABLE IF NOT EXISTS `keyword` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `word` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_2` (`id`),
    KEY `id` (`id`)
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;
    
    /*create table tbl_title */  
     CREATE TABLE IF NOT EXISTS `tbl_title` (
    `title` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
    `domain` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
```

####2. You may install nokogiri by the following command in shell
```shell
    sudo gem install nokogiri
```
####3. What each file does

`main.rb`
``` 
    It acts as the main function which call all the pre-built function to finish all
    the job
```

`socket_http.rb`
```
    This file aims at scarpy html file from a given url.
    Note that the http implementation is based on socket.
```
`extract.rb`
```
    This part I write two functions to finish the extracted jobs.
    The function named extract_target is used to process the doccument 
    and return two hash tables (title=>url pairs) and (keyword=>url pair)
    The function named get_text aims at getting the text of a node
```
`stroage.rb`
```
    As the name suggested, it is a class for manipulating database ,for example: 
    insert data, checksif a given word existes in table.
```
#### 4. Make a Try
Go to command line and `cd` to the dir  of  main.rb and run    

```shell   
    ruby main.rb
```
###Bug
However, There still some bugs in this demo. Any suggestion will be welcome. 

*  It will arise ` Connection reset by peer (Errno::ECONNRESET)` error,but i think  that it was
caused by  the rejection of  the search engine 
* speed needs to be improved

### Licences 
Licensed under the [MIT License](http://opensource.org/licenses/MIT)
