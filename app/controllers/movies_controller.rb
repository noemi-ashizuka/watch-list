class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    if params[:query].present?
      @movies = @movies.search_by_title(params[:query])
    end
  end
end
