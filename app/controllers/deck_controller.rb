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
  @round = Round.find_by(user_id: session[:session_id])
  erb :'/deck/show'
end

post '/deck/:deck_id' do
  @cards = Card.where(deck_id: params[:deck_id])
  @deck = Deck.find_by(id: params[:deck_id])
  @round = Round.new(user_id: session[:session_id], deck_id: params[:deck_id])
  if @round.save
    @cards.each do |card|
      Guess.find_or_create_by(card_id: card.id, round_id: @round.id)
    end
    redirect "/deck/#{params[:deck_id]}/play"
  else
    redirect "/deck/#{params[:deck_id]}"
  end
end

get '/deck/:deck_id/card/:card_id' do
  @card = Card.find_by(id: params[:card_id])
  @round = Round.find_by(user_id: session[:session_id])
  @guess = Guess.find_by(round_id: @round.id, card_id: params[:card_id])
  erb :'/card/show'
end

post '/deck/:deck_id/card/:card_id' do
  # @round = Round.new(user_id: session[:session_id], deck_id: params[:deck_id])
  @cards = Card.where(deck_id: params[:deck_id])
  redirect "/deck/#{params[:deck_id]}/card/#{params[:card_id]}"
end

get '/deck/:deck_id/play' do
  @deck = Deck.find_by(id: params[:deck_id])
  @cards = Card.where(deck_id: params[:deck_id])
  @round = Round.last
  @guess = Guess.where(round_id: @round.id)
  @counter = 0
  erb :'deck/play'
end

post '/deck/:deck_id/play' do
  @round = Round.last
  @guess = Guess.find_by(round_id: @round.id, card_id: params[:card_id])
  @round.attempt += 1
  @round.save
  if params[:correct] == "Correct"
    @guess[:correct?] = true
    @guess.save
  end
  redirect "/deck/#{params[:deck_id]}/play"
end
