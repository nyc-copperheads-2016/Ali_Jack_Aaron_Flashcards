class Deck < ActiveRecord::Base
  # Remember to create a migration!
  validates :name, presence: true
  has_many :rounds
  has_many :cards

  has_many :users, through: :rounds
end
