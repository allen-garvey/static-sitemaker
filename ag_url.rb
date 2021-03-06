module AG_URL
	class Url
		include Comparable
		attr_reader :url

		def initialize(url)
			@url = url
		end

		def file_extension()
			path = relative_path()
			if path !~ /\./ and path =~ /\/$|\/[^.]+$/
				'/'
			else
				path.scan(/\.[a-z]+\/?$/i)[0].gsub(/\//, '')
			end
		end

		def enclosing_dir()
			if file_extension() == '/'
				relative_path()
			else
				dir = relative_path().gsub(/\/[^\/]+\/?$/, '')
				if dir == ''
					'/'
				else
					dir
				end
			end
		end

  		def tld()
  			@url.gsub(/^https?:\/\/(www.)?|\b\/.*$/, '')
  		end

  		def relative_path()
  			nested_path = @url.scan(/\.[a-z]+\/.*$/i)
  			if nested_path.length == 0
  				'/'
  			else
  				nested_path[0].gsub(/^\.[a-z]+|\?.*$/, '')
  			end
  		end

  		def to_s()
			@url
		end

		def <=> other
    		@url.gsub(/\/+$/, '') <=> other.url.gsub(/\/+$/, '')
  		end
	end
end