class MoviesController < ApplicationController
  require 'net/http'
  before_filter :signed_in_and_admin_user,     only: [:destroy, :create, :update, :new, :edit]

  autocomplete :movie, :name, :full => true

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
    @movie_imdb_rating = getImdbRating(@movie.name)
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

  def autocomplete_search
    @search_string = params[:name]
    @movies = Movie.where("name like ?", "%#{params[:name]}%")
    if @movies.count == 1
      @movie = @movies.first
      redirect_to @movie
    else
      render 'search'
    end
  end

  def edit   
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(params[:movie])
      flash[:success] = "Movie Updated"
      redirect_to @movie
    else
      render 'edit'
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

  def getImdbRating(movie)
    uri = URI.parse(URI.encode("http://www.omdbapi.com/?t="+movie))
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    hash = JSON.parse response.body   
    if hash['imdbRating'].nil?
      hash['imdbRating'] = "Not Available"
    else
      hash['imdbRating'] = hash['imdbRating'].to_s
    end
    
  end




end
