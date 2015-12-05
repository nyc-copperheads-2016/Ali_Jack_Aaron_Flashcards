get '/deck/new' do
  erb :'/deck/form'
end

post '/deck/create' do
  deck = Deck.new(name: params[:name])
    if deck.save
      redirect '/flashcards/index'
    else
      erb :'/sessions/new', locals: { errors: user.errors.full_messages }
    end
end

get '/deck/:deck_id' do
  @cards = Card.where(deck_id: params[:deck_id])
  @deck = Deck.find_by(id: params[:deck_id])
  # p @temp_deck.slice!(params[:card_id])
  # p params
  erb :'/deck/show'
end

post '/deck/:deck_id' do
  @cards = Card.where(deck_id: params[:deck_id])
  @deck = Deck.find_by(id: params[:deck_id])
  @temp_deck = @deck.dup
  p @temp_deck
  erb :'/deck/show'
end

get '/deck/:deck_id/card/:card_id' do
  @card = Card.find_by(id: params[:card_id])
  # binding.pry
  erb :'/card/show'
end

post '/deck/:deck_id/card/:card_id' do
  @round = Round.new(user_id: session[:user_id], deck_id: params[:deck_id])
  @cards = Card.where(deck_id: params[:deck_id])
  if @round.save
    redirect "/deck/#{params[:deck_id]}/card/#{params[:card_id]}"
  else
    redirect "/deck/#{params[:deck_id]}/card/#{params[:card_id]}"
  end
end


