module StaticPagesHelper

	def app_name
		"Movie_DB"
	end

	def getImdbRating(movie)
		uri = URI.parse(URI.encode("http://www.omdbapi.com/?t="+movie))
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Get.new(uri.request_uri)
		response = http.request(request)

		hash = JSON.parse response.body		
		if hash['imdbRating'].nil?
			hash['imdbRating'] = "Not Available"
		else
			hash['imdbRating'] = hash['imdbRating'].to_s
		end
		
	end

end
