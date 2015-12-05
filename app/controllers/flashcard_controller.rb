get '/flashcards/index' do
  @user = User.find_by(id: session[:user_id])
  @decks = Deck.all
  @cards = Card.where(deck_id: @decks[0].id)
  erb :'/flashcards/index'
end

delete '/flashcards/logout' do
  session.clear
  redirect '/'
end
