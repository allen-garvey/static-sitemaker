# replaces html classes with inline css
#use single quotes in CSS to get nicer output (e.g. font-family)

require 'fileutils'
# require 'nokogiri'
load 'ag_url.rb'

TOP_LEVEL_URL = AG_URL::Url.new "http://www.allengarvey.co"
OUTPUT_DIR = "~/Documents/" #note trailing slash
FILE_EXTENSIONS = ['.php', '.html', '/'] #file extensions to staticize
pages_downloaded = []


#accepts argument of type AG_URL::Url
def stacticizer(url)
	if pages_downloaded.include?(url) or url.tld != TOP_LEVEL_URL.tld or !FILE_EXTENSION.include?(url.file_extension)
		return
	end
	page = Nokogiri::HTML(open(url.url))

	full_file_name = OUTPUT_DIR + url.relative_path + FILE_EXTENSION
	FileUtils.mkdir_p full_file_name
	File.open(full_file_name, 'a') {|f| f.write(page) }
	
	pages_downloaded.push url
	
	page.css('a').each do |a_tag|
		stacticizer(AG_URL::Url.new a_tag['href'])
	end
end






