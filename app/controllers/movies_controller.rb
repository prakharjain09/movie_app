class MoviesController < ApplicationController
  before_filter :signed_in_and_admin_user,     only: [:destroy, :create, :update, :new]

  def new
  	@movie = Movie.new
  end

  def create
  	@movie = Movie.new(params[:movie])
  	if @movie.save
      flash[:success] = "Movie Created"
  	  redirect_to @movie
  	else
  		render 'new'
  	end
  end

  def show
  	@movie = Movie.find(params[:id])
    if signed_in?
      @review = current_user.reviews.build(movie_id: params[:id])
      @rating = current_user.ratings.find_by_movie_id(params[:id])
      if @rating.nil?
        @rating = current_user.ratings.build(movie_id: params[:id], value: 0)
      end
    end
  end

  def index
	  @movies, @alphaParams = Movie.alpha_paginate(params[:letter], {:default_field => "All"}){|movie| movie.name}
  end


  def destroy
    Movie.find(params[:id]).destroy
    flash[:success] = "Movie destroyed."
    redirect_to movies_url
  end

  def search
    if !params[:search_string].nil?
      @search_string = params[:search_string]
      @movies = Movie.search(@search_string)
      render 'search'
    else 
      @movies, @alphaParams = Movie.alpha_paginate(params[:letter], {:default_field => "All"}){|movie| movie.name}
      render 'index'
    end
  end

private
	def signed_in_and_admin_user
		if !signed_in?
	        store_location
    			redirect_to signin_url, notice: 'Please sign in'
		else 
      if !current_user.admin?
          redirect_to root_url, notice: 'You need admin rights to acces the page'
      end
		end
	end





end
