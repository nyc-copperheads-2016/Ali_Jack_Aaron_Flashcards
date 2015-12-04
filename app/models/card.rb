class Card < ActiveRecord::Base
  validates :question, presence: true
  validates :answer, presence: true
  has_many :guesses
  belongs_to :deck
end
