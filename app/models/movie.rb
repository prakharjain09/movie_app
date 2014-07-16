# == Schema Information
#
# Table name: movies
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  director     :string(255)
#  info         :string(255)
#  cast         :string(255)
#  release_date :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Movie < ActiveRecord::Base
  attr_accessible :cast, :director, :info, :name, :release_date, :total_rating, :total_votes
  after_initialize :init

  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :watch_movies, dependent: :destroy


  validates :name, presence: true, length: { maximum: 50 }

	def self.search(query)
	  where("name like ?", "%#{query}%")
	end

  def init
    self.total_rating  ||= 0           #will set the default value only if it's nil
    self.total_votes ||= 0 
  end

end
