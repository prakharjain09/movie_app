class ReviewsController < ApplicationController

  before_filter :signed_in_user, only: [:create, :destroy]

  def create
    @review = current_user.reviews.build(params[:review])
    @movie = Movie.find(params[:review][:movie_id])
    if @review.save
      redirect_to @movie
    else
      render "movies/show"
    end
  end

  def destroy

    review = Review.find_by_id(params[:id])
    if !review.nil?
      if !current_user.admin?  && !current_user?(review.user)
         redirect_to review.movie, notice: 'you need to be admin in order to delete reviews of other users'
      else
        @movie = review.movie
        review.destroy
        redirect_to @movie
      end
    else 
      redirect_to movies_path
    end
  end

private
  def signed_in_user
    if !signed_in?
      redirect_to signin_url, notice: 'Please sign in'
    end
  end





end
