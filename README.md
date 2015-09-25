#Static Sitemaker

Script to save the compiled output files (.php etc) to static .html files.

##Dependencies

* Ruby 2.*
* Nokogiri

##Getting Started

* Download or clone the project and `cd` into the project directory
* If you don't have Nokogiri already installed, type `gem install nokogiri`
* Edit the `TOP_LEVEL_URL` constant inside the `static_sitemaker.rb` file to point to the homepage of your website and the `OUTPUT_DIR` constant to the path you want the static files to be saved in "note it must end in `/` and cannot be the `~` form of path"

##Notes

* If you have orphan pages (pages that are not linked to from anywhere) they will not be saved
* Static assets (js, images, css, ico) will not be saved
* Due to a bug in `FileUtils.mkdir_p` `OUTPUT_DIR` cannot contain `~` (e.g. `~/Documents`)

##License

Static Sitemaker is released under the MIT License. See license.txt for more details.