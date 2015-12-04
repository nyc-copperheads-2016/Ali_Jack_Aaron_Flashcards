get '/deck/new' do
  erb :'/deck/form'
end

post '/deck/create' do
  p params[:name]
  deck = Deck.new(name: params[:name])
    if deck.save
      redirect '/flashcards/index'
    else
      erb :'/sessions/new', locals: { errors: user.errors.full_messages }
    end
end

get '/deck/:id' do
  @cards = Card.where(deck_id: params[:id])
  @current_card = @cards.shuffle.shift.question
  erb :'/deck/show'
end

post '/deck/:deck_id/card/:card_id' do
  @round = Round.new(user_id: session[:id], deck_id: params[:id])
  redirect "/deck/<%= #{params[:deck_id]} %>"
end
