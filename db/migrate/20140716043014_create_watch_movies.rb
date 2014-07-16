class CreateWatchMovies < ActiveRecord::Migration
  def change
    create_table :watch_movies do |t|
      t.integer :user_id
      t.integer :movie_id

      t.timestamps
    end

    add_index :watch_movies, :user_id
    add_index :watch_movies, [:user_id, :movie_id], unique: true
  end
end
