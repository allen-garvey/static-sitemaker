#saves all pages in site as static .html or .php files starting from top level url (homepage)
#note if you have orphan pages that are not linked from anywhere, they will not be saved
#you will also have to move over all your static assents i.e. CSS, JS, txt and images yourself manually

require 'fileutils'
require 'nokogiri'
require 'open-uri'
load 'ag_url.rb'

TOP_LEVEL_URL = AG_URL::Url.new "http://allengarvey.com"
OUTPUT_DIR = "~/Documents/" #note trailing slash
FILE_EXTENSION = '.php' #.html or .php
FILE_EXTENSIONS = ['.php', '.html', '/'] #file extensions to staticize
DEFAULT_FILE_NAME = 'index' #used for files with out names, such as dir root '/'

$page_urls = []

#accepts argument of type AG_URL::Url
def build_url_list(url)
	page = Nokogiri::HTML(open(url.url))
	$page_urls.push url
	page.css('a').each do |a_tag|
		new_url = AG_URL::Url.new a_tag['href']
		unless $page_urls.include?(new_url) or new_url.tld != TOP_LEVEL_URL.tld or !FILE_EXTENSIONS.include?(new_url.file_extension)
			build_url_list(new_url)
		end
	end
end

#accepts argument of type AG_URL::Url
def save_page_files(url)
	page = Nokogiri::HTML(open(url.url))
	path = url.relative_path
	if path =~ /\/$/
		path += DEFAULT_FILE_NAME
	end
	full_file_name = OUTPUT_DIR + url.relative_path + FILE_EXTENSION
	FileUtils.mkdir_p full_file_name
	File.open(full_file_name, 'a') {|f| f.write(page) }
end


build_url_list(TOP_LEVEL_URL)
puts $page_urls

$page_urls.each do |url|
	save_page_files(url)
end




