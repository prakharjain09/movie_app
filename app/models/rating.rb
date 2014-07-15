class Rating < ActiveRecord::Base
  attr_accessible :movie_id, :user_id, :value

  belongs_to :user
  belongs_to :movie

  validates :user_id, presence: true
  validates :movie_id, presence: true
  validates :value, presence: true



end
