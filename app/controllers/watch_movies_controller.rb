class WatchMoviesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

  def create
  	@movie = Movie.find(params[:watch_movie][:movie_id])
    current_user.add_to_watch_list!(@movie)
  end


  def destroy
    @movie = WatchMovie.find(params[:id]).movie
    current_user.remove_from_watch_list!(@movie)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  private
	def signed_in_user
		unless signed_in?
			redirect_to signin_url, notice: 'Please sign in'
		end
	end


end