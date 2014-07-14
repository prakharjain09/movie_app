class MoviesController < ApplicationController
  before_filter :admin_user,     only: [:destroy, :create, :update]

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


  def destroy
    Movie.find(params[:id]).destroy
    flash[:success] = "Movie destroyed."
    redirect_to movies_url

  end

private
	def signed_in_user
		unless signed_in?
	        store_location
			redirect_to signin_url, notice: 'Please sign in'
		end
	end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end





end
