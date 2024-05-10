class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :lists, through: :bookmarks

  validates :title, uniqueness: true, presence: true
  validates :overview, presence: true

  def self.top_5_rated
    order(rating: :desc).take(5)
  end

  def self.most_added
    # most added to lists bookmark
    Movie
    .joins(:bookmarks)
    .group('movies.id')
    .order('COUNT(bookmarks.movie_id) DESC')
    .limit(10)
  end
end
