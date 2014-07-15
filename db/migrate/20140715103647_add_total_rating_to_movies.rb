class AddTotalRatingToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :total_rating, :integer, default: 0
  end
end
