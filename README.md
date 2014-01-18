Parse Usebitcoins.info
=================

With this little web crawler you can parse and get all links* from [Usebitcoins](http://www.usebitcoins.info), a popular Bitcoin directory. When we say _links_, we mean stores, services, goods and anything related to Bitcoin that have a link. 

**You can access this data by two ways:**

* Download this database as JSON, XML and SQL insertion script (MySQL and Postgresql) and simply use as you want.
* Download this project and run by yourself the parser. It's easy and will give you the latest data of Usebitcoins.

We will explain detail how you can do this two things, don't be scared - it's really easy.

![The almost 'beautiful' interface of our tool :P](http://farm4.staticflickr.com/3811/11920259715_374a2e788d_b.jpg)

Before the gold, the basics:
---------------
Currently we have a lot of links in our database, and every link have the following attributes:
```ruby
name # => The name of the store/service/item.
description # => Description of this store/service/item.
url # => The link itself.
image_url # => A link of the store/service/item image.
type # => Can be 'Services', 'Goods', 'Leisure' and 'Bitcoin'
category # => The category that this item belongs to (e.g: 'Electronics', 'Hosting services')
```

You can choose the better way to download this database: XML, JSON or SQL insertion script (MySQL and Potgresql supported). We don't know how much links we have, but is probably something above 1.700 links. Well, I think you already know the basics, let's advance. If you want something more, feel free to [create a new issue](https://github.com/paladini/parse-usebitcoins/issues) with your tip / question. 

Directly download the database:
---------------
If you want directly import the database to your website / software / service, you're on the rigth place. 

###Downloads:###

* [MySQL Script](https://github.com/paladini/parse-usebitcoins/raw/master/public/parse_usebitcoins/data-mysql.sql)
* [Postgresql Script](https://github.com/paladini/parse-usebitcoins/raw/master/public/parse_usebitcoins/data-postgresql.sql)
* [JSON](https://github.com/paladini/parse-usebitcoins/raw/master/public/parse_usebitcoins/data.json)
* [XML](https://github.com/paladini/parse-usebitcoins/raw/master/public/parse_usebitcoins/data.xml)

After download your desired database, just import it to your project. Don't know do that? [MySQL Script](http://dev.mysql.com/doc/refman/5.0/en/mysql-batch-commands.html), [Postgresql Script](http://stackoverflow.com/questions/9736085/run-a-postgresql-sql-file-using-command-line-args). XML and Json isn't language agnostic, so you must find a tutorial for your project language.  

Download the tool and get the latest data:
---------------
If you want download the most recent data, you need to run Parse Usebitcoins in your computer - but it's simple! If you're here, you probably have Ruby on Rails installed in your machine, but if not, [click here](http://rubyonrails.org/download). 

**1º Step ->** You must download our entire project. [Click here to download](https://github.com/paladini/parse-usebitcoins/archive/master.zip).

**2º Step ->** Extract the project in a folder that you will remember. Now open your Terminal / Console and navigate to the folder where you extracted the Parse Usebitcoins. We need setup some things, but it's quickly. Run these commands on your Terminal:
```ruby
bundle install
bundle exec rake db:migrate
```

**3º Step ->** Now we can start parsing and crawling some data, let's start the process of getting the most recent data from Usebitcoins.info. Just type the following in your Terminal:
```ruby 
rake data:parse
```

**4º Step ->** Finally, just make a coffee and wait. The parsing process may take a long, when it finish you'll can see the generated files in `public/parse_bitcoins`, inside the Parse Usebitcoins folder.

If you have any questions, [let us know](https://github.com/paladini/parse-usebitcoins/issues/new).

Why we do that?
---------------
We believe in the power of Bitcoin and we really trust it can change the world. Anyone who defends Bitcoin is in favor to a decentralized economy and power. Of course, the anonymity is very important factor too. We don't believe just that, we believe that the knowledge must be free, must be accessible to everyone - and finally make a truly Bitcoin revolution. Bitcoin is free, is open-source, collaborative. We agree with that, and this is our reasons. 

If you agree with us, you must know [BTC-Stores](http://www.btc-stores.com). **The human knowledge belongs to humanity.**

About and License
---------------
This little tool was created by [Fernando Paladini](http://fpaladini.blogspot.com), a brazilian student and the main-developer of [BTC-Stores](http://www.btc-stores.com), the first open-source Bitcoin directory in the world. This project is distributed under GPL v2 License. 
