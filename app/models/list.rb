class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :photo

  validates :name, uniqueness: true, presence: true

  def self.most_rated
    List
    .joins(:reviews)
    .group('lists.id')
    .order('AVG(reviews.rating) DESC')
    .limit(10)
  end

  def average_rating
    ratings = []
    self.reviews.each do |review|
      ratings << review.rating
    end
    ratings.sum / self.reviews.size
  end
end
