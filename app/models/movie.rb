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
  attr_accessible :cast, :director, :info, :name, :release_date

  validates :name, presence: true, length: { maximum: 50 }


end
