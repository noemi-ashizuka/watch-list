require 'rest-client'
require 'faker'

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
      rating: movie_data['vote_average'].to_f.round(1)
    )
  end
  p "Creating #{movie.title}"
end

puts "There are #{Movie.count} movies in the database"

puts "Addind Lists..."

classics = List.create(name: "Classics")

5.times do
  Bookmark.find_or_create_by!(movie: Movie.all.sample, list: classics, comment: Faker::TvShows::Buffy.quote)
end

anime = List.create(name: "Anime")


5.times do
  Bookmark.find_or_create_by!(movie: Movie.all.sample, list: anime, comment: Faker::TvShows::Buffy.quote)
end

must_watch = List.create!(name: "Must Watch")

5.times do
  Bookmark.find_or_create_by!(movie: Movie.all.sample, list: must_watch, comment: Faker::TvShows::Buffy.quote)
end

puts "There are #{List.count} lists and #{Bookmark.count} bookmarks."

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
