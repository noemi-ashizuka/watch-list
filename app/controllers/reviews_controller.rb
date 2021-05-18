class ReviewsController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @list = params[:list_id]
    @review.list = List.find(@list)
    respond_to do |format|
      if @review.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend(
            'reviews-list',
            partial: 'reviews/review_message',
            locals: { review: @review }
          )
        end
        format.html { render partial: 'review_message', locals: { review: @review }, status: :ok }
      else
        format.html { render partial: 'form', locals: { list: @list, review: @review }, status: :unprocessable_entity }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
