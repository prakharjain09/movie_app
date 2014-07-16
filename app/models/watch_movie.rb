class WatchMovie < ActiveRecord::Base
  attr_accessible :movie_id

  belongs_to :user
  belongs_to :movie

  validates :user_id, presence: true
  validates :movie_id, presence: true

end
