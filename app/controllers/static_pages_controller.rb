class StaticPagesController < ApplicationController
  def home
  	@movies, @alphaParams = Movie.alpha_paginate(params[:letter]){|movie| movie.name}
  	
  end

  def help
  end

  def about
  end

end
