class MoviesController < ApplicationController

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
  end

  def index
	@movies, @alphaParams = Movie.alpha_paginate(params[:letter]){|movie| movie.name}
  end


  def delete
  	
  end



end
