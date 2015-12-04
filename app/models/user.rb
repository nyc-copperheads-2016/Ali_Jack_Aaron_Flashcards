class User < ActiveRecord::Base
  # Remember to create a migration!
  validates :username, presence: true
  validates :username, length: { minimum: 5 }

  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  has_many :rounds
  has_many :decks, through: :rounds

end
