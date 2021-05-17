require 'rest-client'

Bookmark.destroy_all
List.destroy_all
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

puts "Adding a few more manually because this api sucks"

Movie.create!(
  title: "Wonder Woman 1984",
  overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s",
  poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
  rating: 6.9
)

Movie.create!(
  title: "Batman and Robin",
  overview: "Batman and Robin try to keep their relationship together even as they must stop Mr. Freeze and Poison Ivy from freezing Gotham City.",
  poster_url: "https://cdn.shopify.com/s/files/1/0057/3728/3618/products/9f40e2dbe5a338f8616ebad6239ce461_8a7b8276-f6be-4c0d-9631-70be60f1ec2f_480x.progressive.jpg?v=1573584326",
  rating: 3.8
)

Movie.create!(
  title: "Titanic",
  overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.",
  poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg",
  rating: 7.9
)

Movie.create!(
  title: "Ocean's Eight",
  overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.",
  poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg",
  rating: 5.0
)

Movie.create!(
  title: "Star Wars",
  overview: "Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee and two droids to save the galaxy from the Empire's world-destroying battle station, while also attempting to rescue Princess Leia from the mysterious Darth Vader.",
  poster_url: "https://cdn.shopify.com/s/files/1/0057/3728/3618/products/23fd3ba334c1e8e84c96906497d577bf_6d652cf7-d705-42d2-96aa-2c3963f8a178_480x.progressive.jpg?v=1573613876",
  rating: 8.6
)

Movie.create!(
  title: "Back to the future",
  overview: "Marty McFly, a 17-year-old high school student, is accidentally sent thirty years into the past in a time-traveling DeLorean invented by his close friend, the eccentric scientist Doc Brown.",
  poster_url: "https://cdn.shopify.com/s/files/1/0057/3728/3618/products/9d8e73e436b536a7c81644c6e9877c7a_1c9d0f90-9991-4326-8f37-3dd980abeacf_480x.progressive.jpg?v=1573590262",
  rating: 8.5
)

Movie.create!(
  title: "Spice World",
  overview: "World famous pop group the Spice Girls zip around London in their luxurious double decker tour bus having various adventures and performing for their fans.",
  poster_url: "https://www.themoviedb.org/t/p/original/o9mOuqpliPG71JDviCGC1RJTime.jpg",
  rating: 3.5
)

puts "There are #{Movie.count} movies in the database"
