class Deck < ActiveRecord::Base
  # Remember to create a migration!
  validates :name, presence: true
end
