class BookmarksController < ApplicationController
  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to list_path(@list) }
      else
        format.html { render template: 'lists/show', status: :unprocessable_entity }
      end
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
