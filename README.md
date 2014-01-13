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

You can choose the better way to download this database: XML, JSON or SQL insertion script (MySQL and Potgresql supported).

Directly download the database:
---------------
Currently we have the data in 

Why we do that?
---------------
We believe in the power of Bitcoin and we really trust it can change the world. Anyone who defends Bitcoin is in favor to a decentralized economy and power. Of course, the anonymity is very important factor too. We don't believe just that, we believe that the knowledge must be free, must be accessible to everyone - and finally make a truly Bitcoin revolution. Bitcoin is free, is open-source, collaborative. We agree with that, and this is our reasons. 

If you agree with us, you must know [BTC-Stores](http://www.btc-stores.com). **The human knowledge belongs to humanity.**

About and License
---------------
This little tool was created by Fernando Paladini, a brazilian student and the main-developer of [BTC-Stores](http://www.btc-stores.com), the first open-source Bitcoin directory in the world. This project is distributed under GPL v2 License. 
