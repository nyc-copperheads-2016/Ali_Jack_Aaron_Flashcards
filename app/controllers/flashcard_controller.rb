# get '/flashcards'
get '/flashcards/index' do
  # This would be a good place to use a helper.  Maybe a current_user method?
  #
  # @user = User.find_by(id: session[:user_id])
  @user = current_user
  @decks = Deck.all
  # Use the AR associations to find other objects that are related:
  @cards = @decks[0].cards; # Card.where(deck_id: @decks[0].id)
  erb :'/flashcards/index'
end

# I think this route belongs in your session controller.  And, I dont think
# that flashcard is the proper resource.
delete '/flashcards/logout' do
  session.clear
  # Guess.destroy_all
  # If you wanted to remove all the guesses, above would do the trick.  The code
  # below (not sure how it works...) is confusing.
  @guess = Guess.all
  @guess.delete(Guess.all)

  redirect '/'
end

get '/flashcards/stats' do
  # @user = User.find_by(id: session[:user_id])
  @user = current_user
  # I think you want to show stats for the logged in user only... perhaps:
  # @rounds = current_user.rounds
  @rounds = Round.all
  unless @rounds.empty?
    @deck = @rounds.first.deck
    # @deck = Card.where(deck_id: @rounds[0].deck_id)
  end
  erb :'/flashcards/show'
end
