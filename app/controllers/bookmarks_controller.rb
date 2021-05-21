class BookmarksController < ApplicationController
  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to list_path(@list) }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'bookmark_form',
            partial: 'bookmarks/modal',
            locals: { bookmark: @bookmark, list: @list }
          )
        end
        format.html { render template: 'bookmarks/modal', status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
