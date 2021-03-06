class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :director
      t.string :info
      t.string :cast
      t.date :release_date

      t.timestamps
    end
  end
end
