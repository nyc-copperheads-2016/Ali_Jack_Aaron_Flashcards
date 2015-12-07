get '/flashcards/index' do
  @user = User.find_by(id: session[:user_id])
  @decks = Deck.all
  @cards = Card.where(deck_id: @decks[0].id)
  erb :'/flashcards/index'
end

delete '/flashcards/logout' do
  session.clear
  @guess = Guess.all
  @guess.delete(Guess.all)

  redirect '/'
end

get '/flashcards/stats' do
  @user = User.find_by(id: session[:user_id])
  @rounds = Round.all
  unless @rounds.empty?
    @deck = Card.where(deck_id: @rounds[0].deck_id)
  end
  erb :'/flashcards/show'
end
