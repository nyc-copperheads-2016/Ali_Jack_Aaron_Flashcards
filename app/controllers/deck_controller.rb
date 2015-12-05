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

get '/deck/:deck_id/card/:card_id' do
  @cards = Card.where(deck_id: params[:deck_id])
  @card_shuffle = @cards.shuffle
  @current_card = @card_shuffle.shift.question
  erb :'/deck/show'
end

get '/deck/:deck_id/card/:card_id/show_answer' do
  @card = Card.find_by(id: params[:card_id])
  # binding.pry
  erb :'/card/show'
end

post '/deck/:deck_id/card/:card_id/show_answer' do
  @round = Round.new(user_id: session[:user_id], deck_id: params[:deck_id])
  @cards = Card.where(deck_id: params[:deck_id])
  redirect "/deck/#{params[:deck_id]}/card/#{params[:card_id]}/show_answer"
end


