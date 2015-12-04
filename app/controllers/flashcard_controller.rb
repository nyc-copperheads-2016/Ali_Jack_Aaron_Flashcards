get '/flashcards/index' do
  @user = User.find_by(id: session[:user_id])
  @decks = Deck.all
  erb :'/flashcards/index'
end

delete '/flashcards/logout' do
  session.clear
  redirect '/'
end
