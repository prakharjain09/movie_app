class Review < ActiveRecord::Base
  attr_accessible :content, :movie_id

  belongs_to :user
  belongs_to :movie

  validates :user_id, presence: true
  validates :movie_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }

  default_scope order: 'reviews.created_at DESC'


end
