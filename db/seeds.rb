require 'rest-client'

puts 'Cleaning the db'

Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts 'Cleaning done'

puts 'Fetching genres'
genres_url = "https://api.themoviedb.org/3/genre/movie/list?api_key=#{ENV['MOVIES_API']}&language=en-US"

genres_doc = JSON.parse(RestClient.get(genres_url))

genre_ids = genres_doc['genres'].map { |genre| genre['id'] }

puts 'Genres created'

puts 'Creating movies'

movies = genre_ids.map do |genre_id|
  url = "https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['MOVIES_API']}&with_genres=#{genre_id}&sort_by=revenue.desc"

  movies_doc = JSON.parse(RestClient.get(url))

  movies_doc['results'].first(10)
end

movies.flatten.each do |movie_data|
  movie = Movie.find_by(title: movie_data['title'])
  unless movie
    movie = Movie.create!(
      title: movie_data['title'],
      overview: movie_data['overview'],
      poster_url: "https://image.tmdb.org/t/p/w500/#{movie_data['poster_path']}",
      rating: movie_data['vote_average'].to_f
    )
  end
  p "Creating #{movie.title}"
end

puts "There are #{Movie.count} movies in the database"

# FROM THE FAKE API

# url = 'http://tmdb.lewagon.com/movie/top_rated'

# json_doc = JSON.parse(RestClient.get(url))

# movies = json_doc['results']

# movies.take(20).each do |movie|
#   new_movie = Movie.create!(
#     title: movie['title'],
#     overview: movie['overview'],
#     poster_url: "https://image.tmdb.org/t/p/w500/#{movie['poster_path']}",
#     rating: movie['vote_average']
#   )
#   p "Creating #{new_movie.title}"
# end

# puts "Adding a few more manually because this api sucks"

# Movie.create!(
#   title: "Wonder Woman 1984",
#   overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s",
#   poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
#   rating: 6.9
# )
