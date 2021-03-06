# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)\

require "net/http"
require "uri"
require 'json'

movie_list = ["The Shawshank Redemption", "The Godfather", "Inception", "The Matrix", "Seven Samurai", "Memento", "Gladiator", "The Dark Knight Rises", " Aliens", "Bicycle Thieves", "Transformers: Age of Extinction", "The Avengers", "Thor", "Dawn of the Planet of the Apes", "3 Idiots", "Planes: Fire & Rescue", "Christmas with a Capital C", "22 Jump Street"]
i=0
movie_list.each do |movie|
	uri = URI.parse(URI.encode("http://www.omdbapi.com/?t="+movie))
	puts uri
	http = Net::HTTP.new(uri.host, uri.port)
	request = Net::HTTP::Get.new(uri.request_uri)
	response = http.request(request)

	hash = JSON.parse response.body
	#puts hash
	
	name = hash["Title"]
	director = hash['Director']
	info = hash['Plot']
	cast = hash['Actors']
	photo = hash['Poster']
	release_date = hash['Released']

	Movie.create(name: name, director: director, info: info, cast: cast, photo: photo, release_date: release_date)
	puts i
	i = i + 1
end



