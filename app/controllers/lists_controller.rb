require 'open-uri'

class ListsController < ApplicationController
  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @movies_list = @list.bookmarks.order(created_at: :desc)
    @bookmark = Bookmark.new
    @review = Review.new
  end

  # def new
  #   @list = List.new
  # end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :index
    end
  end

  def rankings
    @top_5_movies = Movie.top_5_rated
    @most_added_movies = Movie.most_added
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
