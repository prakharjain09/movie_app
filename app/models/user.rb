# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :watch_movies, dependent: :destroy

  before_save :create_remember_token
  before_save { |user| user.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


  def watch_list_contains?(movie)
    watch_movies.find_by_movie_id(movie.id)
  end

  def add_to_watch_list!(movie)
    watch_movies.create!(movie_id: movie.id)
  end

  def remove_from_watch_list!(movie)
    watch_movies.find_by_movie_id(movie.id).destroy
  end

private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end


end
