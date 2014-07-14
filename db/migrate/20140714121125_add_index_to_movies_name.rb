class AddIndexToMoviesName < ActiveRecord::Migration
  def change
  	add_index :movies, :name
  end
end
