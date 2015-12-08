class Round < ActiveRecord::Base
  has_many :guesses
  belongs_to :user
  belongs_to :deck

  # The attempts value is really a counter cache type attribute.  AR can manage
  # this for you.  Read up about it here (http://guides.rubyonrails.org/association_basics.html)
  def attempts
    guesses.count
  end
end
