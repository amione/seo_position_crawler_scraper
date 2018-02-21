require 'rubygems'
require 'selenium-webdriver'
require 'open-uri'
require 'nokogiri'
require 'csv'
require 'addressable'

file_dump = ARGV[0]
read_from = ARGV[1]
domain_name = ARGV[2]

CSV.open("#{file_dump}", "wb") do |csv|
  
	csv << ["seo term","google search position"]

	CSV.foreach("#{read_from}") do |line|

		seo_term = line[0]
		puts "Finding google position for #{seo_term}"
		
		domain_found = false

		@browser = Selenium::WebDriver.for :chrome
		
		uri = Addressable::URI.parse("http://www.google.com/search?q=#{seo_term}")
		url = uri.normalize.to_s

		@browser.get url

		start_searching = "start loop"

		while @browser.page_source.include?("#{domain_name}") == false && start_searching == "start loop"
			sleep 60
			begin
				next_link = @browser.find_element(:id, "pnnext")
				next_link.click
			rescue
				start_searching = "stop loop"
			end
		end

		if @browser.page_source.include?("#{domain_name}") == true
			doc = Nokogiri::HTML(@browser.page_source)
			results_block = doc.xpath("/html/body[@id='gsr']/div[@id='main']/div[@id='cnt']/div[@class='mw'][2]/div[@id='rcnt']/div[@class='col'][1]/div[@id='center_col']/div[@id='res']/div[@id='search']/div/div[@id='ires']/div[@id='rso']/div[@class='_NId'][1]/div[@class='srg']")
			results_links = results_block.css('h3').css('a')

			current_google_url = @browser.current_url

			starting_google_position = current_google_url.split('&start=').last.split('&').first.to_i

			url1 = results_block.css('h3').css('a')[0].attributes["href"].value
			url2 = results_block.css('h3').css('a')[1].attributes["href"].value
			url3 = results_block.css('h3').css('a')[2].attributes["href"].value
			url4 = results_block.css('h3').css('a')[3].attributes["href"].value
			url5 = results_block.css('h3').css('a')[4].attributes["href"].value
			url6 = results_block.css('h3').css('a')[5].attributes["href"].value
			url7 = results_block.css('h3').css('a')[6].attributes["href"].value
			url8 = results_block.css('h3').css('a')[7].attributes["href"].value
			url9 = results_block.css('h3').css('a')[8].attributes["href"].value
			url10 = results_block.css('h3').css('a')[9].attributes["href"].value

			check_url1 = url1.to_s.include?("#{domain_name}")
			check_url2 = url2.to_s.include?("#{domain_name}")
			check_url3 = url3.to_s.include?("#{domain_name}")
			check_url4 = url4.to_s.include?("#{domain_name}")
			check_url5 = url5.to_s.include?("#{domain_name}")
			check_url6 = url6.to_s.include?("#{domain_name}")
			check_url7 = url7.to_s.include?("#{domain_name}")
			check_url8 = url8.to_s.include?("#{domain_name}")
			check_url9 = url9.to_s.include?("#{domain_name}")
			check_url10 = url10.to_s.include?("#{domain_name}")

			if check_url1 == true
				site_position = starting_google_position + 1
				csv << [seo_term,site_position]
				domain_found = true
			end

			if check_url2 == true
				site_position = starting_google_position + 2
				csv << [seo_term,site_position]
				domain_found = true
			end

			if check_url3 == true
				site_position = starting_google_position + 3
				csv << [seo_term,site_position]
				domain_found = true
			end

			if check_url4 == true
				site_position = starting_google_position + 4
				csv << [seo_term,site_position]
				domain_found = true
			end

			if check_url5 == true
				site_position = starting_google_position + 5
				csv << [seo_term,site_position]
				domain_found = true
			end

			if check_url6 == true
				site_position = starting_google_position + 6
				csv << [seo_term,site_position]
				domain_found = true
			end

			if check_url7 == true
				site_position = starting_google_position + 7
				csv << [seo_term,site_position]
				domain_found = true
			end

			if check_url8 == true
				site_position = starting_google_position + 8
				csv << [seo_term,site_position]
				domain_found = true
			end

			if check_url9 == true
				site_position = starting_google_position + 9
				csv << [seo_term,site_position]
				domain_found = true
			end

			if check_url10 == true
				site_position = starting_google_position + 10
				csv << [seo_term,site_position]
				domain_found = true
			end

			@browser.quit

		elsif @browser.page_source.include?("#{domain_name}") == false
			current_google_url = @browser.current_url
			starting_google_position = current_google_url.split('&start=').last.split('&').first.to_i
			not_found_in = starting_google_position + 10
			csv << [seo_term, "term not found in first #{not_found_in} results"]
			@browser.quit
		end
	end #csv for each
end #write csv