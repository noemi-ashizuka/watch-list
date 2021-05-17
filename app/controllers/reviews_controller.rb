class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    list = params[:list_id]
    @review.list = List.find(list)
    respond_to do |format|
      if @review.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend(
            'review_messages',
            partial: 'reviews/review_message',
            locals: { review: @review }
          )
        end
        format.html { redirect_to list_path(@list) }
      else
        format.html { render template: 'bookmarks/modal', status: :unprocessable_entity }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
