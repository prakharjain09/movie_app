class StaticPagesController < ApplicationController
  def home
  	@movies, @alphaParams = Movie.alpha_paginate(params[:letter], {:default_field => "All"}){|movie| movie.name}
  	
  end

  def help
  end

  def about
  end

end
