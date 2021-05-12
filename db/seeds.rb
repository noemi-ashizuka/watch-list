require 'rest-client'

Movie.destroy_all

url = 'http://tmdb.lewagon.com/movie/top_rated'

json_doc = JSON.parse(RestClient.get(url))

movies = json_doc['results']

movies.take(20).each do |movie|
  new_movie = Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500/#{movie['poster_path']}",
    rating: movie['vote_average']
  )
  p "Creating #{new_movie.title}"
end

p "There are #{Movie.count} movies in the database"
