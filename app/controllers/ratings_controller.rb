class RatingsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :update]

  def create
    movie_id = params[:rating][:movie_id]
    value = params[:rating][:value].to_i
    movie = Movie.find(movie_id)
    user_id = current_user.id
    if value<=5 && value>=0
      rating = Rating.where(movie_id: movie_id).find_by_user_id(user_id)
      if rating.nil?
        rating = current_user.ratings.build(movie_id: movie.id, value: value)
        rating.save
        movie.update_attributes(total_votes: movie.total_votes+1, total_rating: movie.total_rating+value)
        movie.save
      else
        old_value = rating.value
        rating.update_attributes(value: value)
        rating.save
        movie = Movie.find(movie_id)
        movie.update_attributes(total_rating: movie.total_rating + value - old_value)
        movie.save
      end
    end
    redirect_to movie
  end

  def update
    movie_id = params[:rating][:movie_id]
    value = params[:rating][:value].to_i
    movie = Movie.find(movie_id)
    user_id = current_user.id
    if value<=5 && value>=0
      rating = Rating.where(movie_id: movie_id).find_by_user_id(user_id)
      if rating.nil?
        rating = current_user.ratings.build(movie_id: movie.id, value: value)
        rating.save
        movie.update_attributes(total_votes: movie.total_votes+1, total_rating: movie.total_rating+value)
        movie.save
      else
        old_value = rating.value
        rating.update_attributes(value: value)
        rating.save
        movie = Movie.find(movie_id)
        movie.update_attributes(total_rating: movie.total_rating + value - old_value)
        movie.save
      end
    end
    redirect_to movie
  end

private
  def signed_in_user
    if !signed_in?
      redirect_to signin_url, notice: 'Please sign in'
    end
  end

end