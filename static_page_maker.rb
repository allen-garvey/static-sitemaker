#saves all pages in site as static .html or .php files starting from top level url (homepage)
#note if you have orphan pages that are not linked from anywhere, they will not be saved
#you will also have to move over all your static assents i.e. CSS, JS, txt and images yourself manually

require 'fileutils'
require 'nokogiri'
require 'open-uri'
load 'ag_url.rb'

TOP_LEVEL_URL = AG_URL::Url.new "http://allengarvey.com"
#add trailing slash to end of output dir and do not use ~/ paths as this will not work- use full path
OUTPUT_DIR = "/Users/Allen\ X/Desktop/allengarvey/"
DEFAULT_FILE_EXTENSION = '.html' #.html or .php
FILE_EXTENSIONS = ['.php', '.html', '/'] #file extensions to staticize
DEFAULT_FILE_NAME = 'index' #used for files with out names, such as dir root '/'
OVERWRITE_OUTPUT_FILES = false

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
	if url.file_extension == '/'
		path = path.gsub(/\/+$/, '') + '/' + DEFAULT_FILE_NAME
	end
	path.gsub!(/^\/+/, '')
	full_file_name = OUTPUT_DIR + path + DEFAULT_FILE_EXTENSION
	# puts full_file_name
	FileUtils.mkdir_p(OUTPUT_DIR + url.enclosing_dir.gsub(/^\/+/, ''))
	write_flag = OVERWRITE_OUTPUT_FILES ? 'w' : 'a'
	File.open(full_file_name, write_flag) {|f| f.write(page) }
end

puts "Building list of files in site..."
build_url_list(TOP_LEVEL_URL)
puts "File list complete. Saving files to #{OUTPUT_DIR}..."

# puts $page_urls
$page_urls.each do |url|
	save_page_files(url)
end



