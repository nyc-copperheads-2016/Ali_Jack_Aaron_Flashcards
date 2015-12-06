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
  @round = Round.find_by(user_id: session[:session_id])
  @cards.each do |card|
      Guess.find_or_create_by(card_id: card.id, round_id: session[:session_id])
  end
  erb :'/deck/show'
end

post '/deck/:deck_id' do
  @cards = Card.where(deck_id: params[:deck_id])
  @deck = Deck.find_by(id: params[:deck_id])
  # @temp_deck = @cards.dup
  @round = Round.find_by(user_id: session[:session_id])

  redirect :"/deck/#{params[:deck_id]}/play"
end

get '/deck/:deck_id/card/:card_id' do
  @card = Card.find_by(id: params[:card_id])
  # binding.pry
  erb :'/card/show'
end

post '/deck/:deck_id/card/:card_id' do
  @round = Round.new(user_id: session[:session_id], deck_id: params[:deck_id])
  @cards = Card.where(deck_id: params[:deck_id])
  @guess = Guess.find_by(round_id: session[:session_id], card_id: params[:card_id])

  if @round.save
    redirect "/deck/#{params[:deck_id]}/card/#{params[:card_id]}"
  else
    redirect "/deck/#{params[:deck_id]}"
  end
end

get '/deck/:deck_id/play' do
  @deck = Deck.find_by(id: params[:deck_id])
  @cards = Card.where(deck_id: params[:deck_id])
  # binding.pry
  @guess = Guess.where(round_id: session[:session_id], correct?: false)
  # binding.pry
  erb :'deck/play'
end


post '/deck/:deck_id/play' do
  @guess = Guess.find_by(round_id: session[:session_id], card_id: params[:card_id])
  # binding.pry
  if params[:correct] == "Correct"
    @guess[:correct?] = true
    @guess.save
  end
  redirect "/deck/#{params[:deck_id]}/play"
end
