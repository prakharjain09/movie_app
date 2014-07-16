class AddAttachmentPhotoToMovies < ActiveRecord::Migration
  def self.up
    change_table :movies do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :movies, :photo
  end
end
