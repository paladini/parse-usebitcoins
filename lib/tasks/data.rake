namespace :data do

  @all_stores = []

	task test: :environment do

		require 'rubygems'
  	require 'open-uri'
  	require 'nokogiri'

  	# Desired URL for running web crawler
  	url = "http://usebitcoins.info/"

  	# Saves the whole page
  	doc = Nokogiri::HTML(open(url))
  	doc.encoding = 'utf-8'

    # Get all links from Usebitcoins.info
    links = []
    doc.css("div.rt-block.menu-block ul li.parent").each do |link|
      link.css("div a").each do |item|
        item_url = item['href'].to_s
        if !item_url.include?('javascript')
          links << item_url
        end
      end
    end
	end

  desc 'Start parse and get all stores from Usebitcoin.info'
	task parse: :environment do

  	require 'rubygems'
    require 'open-uri'
    require 'nokogiri'

    # Desired URL for running web crawller
    url = "http://usebitcoins.info/"

    # Saves the UseBitcoin homepage
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'

    # Get all links from Usebitcoins.info
    links = []
    doc.css("div.rt-block.menu-block ul li.parent").each do |link|
      link.css("div a").each do |item|
        item_url = item['href'].to_s
        
        # If first character is a '/', delete it
        if item_url[0] == '/'
          item_url[0] = ''
        end

        item_url = url.to_s + item_url
        
        # Filter to don't add 'javascript:void(0);' to the url list.
        if !item_url.include?('javascript')
          links << item_url
        end

      end
    end

  	links_length = links.size
    percent = 0
  	links.each_with_index do |url, index|
  		
  		# Get the currently percentage (without repeating the same percentage in Terminal)
  		percent_new = index * 100 / links_length
      if percent == percent_new && percent != 0

      else
        puts "----------------------------------"
        puts "          Loading..." + percent.to_s + "%"
        puts "----------------------------------"
        percent = percent_new
      end

  		# Calling another Rails Task
      Rake::Task['data:parse_category'].invoke(url)
  		Rake::Task['data:parse_category'].reenable
  	end

    # Writing all stores to JSON file
    write_to_file()

  	puts "Finished!!"
  end

  task :parse_category, [:url] => [:environment] do |t, args|

  	require 'rubygems'
  	require 'nokogiri'
    require 'open-uri'

  	# Global variables
  	# -----------------------------------
  	continue = true

  	# Desired URL for running web crawler
  	base_url = "http://usebitcoins.info"
  	url = args['url']

  	#------------------------------------

  	# Get the first page of this category
  	doc = Nokogiri::HTML(open(url))
  	doc.encoding = 'utf-8'

  	# Get the type [e.g: 'good', 'service']
  	type = doc.xpath("//ul[@class='breadcrumbnomarginbottom nopaddingbottom']/li[2]/a")
  	type = type.first.text

    # Get the category [e.g: 'electronics', 'internet provider']
  	category = doc.xpath("//ul[@class='breadcrumbnomarginbottom nopaddingbottom']/li[3]/span")
  	category = category.first.text

    puts "\n\n\n"
    puts "Parsing '" + category.to_s + "':"

    # While have a next page in this category
  	while continue == true do

  		# Parsing the links of all stores of this page
	  	links = []
	  	doc.xpath("//article/h2/a").each do |link|
	  		links << link['href']
	  	end

	  	# Get the store links of this page
	  	links.each do |link|
	  		
        # Download the page of the current store
        puts base_url + link.to_s
	  		this_store = Nokogiri::HTML(open(base_url + link.to_s))
	  		
	  		# Get store title
	  		this_store_title = get_title(this_store)

	  		# Get store description
	  		this_store_description = get_description(this_store)

	  		# Get store link
	  		this_store_link = get_link(this_store)

        # Get store image
        this_store_image = base_url.to_s + get_image(this_store)

	  		# Creating a new Item
	  		item = Item.new(
		      :name => this_store_title, 
		      :description => this_store_description,
		      :url => this_store_link,
          :image_url => this_store_image.to_s,
		      :type => type.to_s,
		      :category => category.to_s
		    )

        # Add this store to array with all stores  
		    @all_stores << item

  		end # end links of this page

  		# Discover if have a next page
  		doc = get_next_page(doc)
  		if doc.nil?
  			continue = false
  		else
  			continue = true
  			doc.encoding = 'utf-8'	
  		end

  	end # end while of all pages
  end # end this task



  # -----------------------------
  #
  #            COMMON
  #
  # ----------------------------- 

  # Function to get Store title
  def get_title(this_store)
  	this_store_title = this_store.xpath("//article/h2/a").text
  	this_store_title = this_store_title.strip
  	this_store_title = this_store_title.capitalize

  	return this_store_title
  end

  # Function to get the Image of the website
  def get_image(this_store)
    this_store_image = this_store.xpath("//article/div[@class='img-fulltext-left']/img/@src").text
    return this_store_image
  end

  # Function to get Store description
  def get_description(this_store)
  	this_store_description = ""
  	this_store.xpath("//article/p | //article/li").each_with_index do |descr, index|
  		this_store_description += descr.content
  	end	
 
  	this_store_description = this_store_description.strip
  	return this_store_description
  end

  # Function to get Store link
  def get_link(this_store)
  	this_store_link = this_store.xpath("//article/p[@class='success']/a/@href")
  	this_store_link = this_store_link.text

  	return this_store_link
  end

  # Function to discover if this category have a have next page
  def get_next_page(doc)
  	
    doc = nil
    have_next_page = doc.xpath("//li[@class='pagination-next']/a")

    # If have a next page, get the page and returns the HTML "doc"
  	if !have_next_page.empty?
  		base_url = "http://usebitcoins.info"
  		have_next_page = have_next_page[0]['href'].to_s
  		doc = Nokogiri::HTML(open(base_url + have_next_page))
  	end
  	
  	return doc
  end

  # Save all stores in JSON, PostgreSQL, XML and others.
  def write_to_file()
    
    # Save to JSON file
    to_json()

    # Save to XML
    to_xml()

    # Save to Postgresql
    to_postgresql()

    # Save to MySQL
    to_mysql()

  end

  # Save all stores to a PostgreSQL insertion script
  def to_postgresql()
    begin 
      file = File.open("public/parse_usebitcoins/data-postgresql.sql", "w")

      @all_stores.each do |store|
        file.write("INSERT INTO stores(name, description, url, image_url, type, category) VALUES
                    ('#{store.name.to_s}', '#{store.description.to_s}', '#{store.url.to_s}', 
                     '#{store.image_url.to_s}', '#{store.type.to_s}', '#{store.category.to_s}');")
      end
    rescue IOError => e
      puts "Some error occoured when trying to save PostgreSQL script."
      print "Error: " + e.to_s
    ensure
      file.close unless file == nil
    end
  end

  # Save all stores to a MySQL insertion script
  def to_mysql()
    begin 
      file = File.open("public/parse_usebitcoins/data-mysql.sql", "w")

      @all_stores.each do |store|
        file.write("INSERT INTO stores(name, description, url, image_url, type, category) VALUES
                    ('#{store.name.to_s}', '#{store.description.to_s}', '#{store.url.to_s}', 
                     '#{store.image_url.to_s}', '#{store.type.to_s}', '#{store.category.to_s}');")
      end
    rescue IOError => e
      puts "Some error occoured when trying to save PostgreSQL script."
      print "Error: " + e.to_s
    ensure
      file.close unless file == nil
    end
  end

  # Save all stores to a JSON file
  def to_json()
    File.open("public/parse_usebitcoins/data.json", "w") { |f| f.write(@all_stores.to_json)}
    puts "Saved at 'public/crawl_usebitcoin/data.json'"
  end

  # Save all stores to a XML file
  def to_xml()
    File.open("public/parse_usebitcoins/data.xml", "w") { |f| f.write(@all_stores.to_xml)}
    puts "Saved at 'public/crawl_usebitcoin/data.xml'"
  end

end
