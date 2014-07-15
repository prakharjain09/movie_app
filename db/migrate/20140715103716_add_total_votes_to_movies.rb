class AddTotalVotesToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :total_votes, :integer, default: 0
  end
end