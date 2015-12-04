class Card < ActiveRecord::Base
  validates :deck_id, presence: true
  validates :question, presence: true
  validates :answer, presence: true
end