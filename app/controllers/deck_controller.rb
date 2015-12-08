get '/deck/new' do
  erb :'/deck/form'
end

# post '/decks' will make a new deck (conventionally)
post '/deck/create' do
  deck = Deck.new(name: params[:name])
  if deck.save
    redirect '/flashcards/index'
  else
    erb :'/sessions/new', locals: { errors: user.errors.full_messages }
  end
end

get '/deck/:deck_id' do
  # Find the primary object that the resource decribes (in this case Deck)
  # and then find your other objects by using the AR associations on that primary
  # object
  # ie.
  # deck = Deck.find_by(id: params[:deck_id])
  # @cards = deck.cards
  # @round = current_user.rounds.last

  @cards = Card.where(deck_id: params[:deck_id])
  @deck = Deck.find_by(id: params[:deck_id])
  @round = Round.find_by(user_id: session[:session_id])
  erb :'/deck/show'
end

# This method is confusing to me.  It does not appear to be working on the resource
# that it claims to be.   Overall, I'm just not clear about its purpose.
post '/deck/:deck_id' do
  # @deck = Deck.find_by(id: params[:deck_id])
  # @cards = @deck.cards

  # @cards = Card.where(deck_id: params[:deck_id])

  # if this is not being used, please dont leave it in...
  @round = Round.all
  @round = Round.create(user_id: session[:session_id], deck_id: params[:deck_id])
  # binding.pry
  if @round.save && @round.attempt <= @cards.count
    # binding.pry
    @cards.each do |card|
      Guess.create(card_id: card.id, round_id: @round.id)
    end
    redirect "/deck/#{params[:deck_id]}/play"
  else
    redirect "/deck/#{params[:deck_id]}"
  end
end

# because the deck can be gotten through the card, the deck_id portion is
# extranneous.  The get route should be GET '/cards/:id'
get '/deck/:deck_id/card/:card_id' do
  @card = Card.find_by(id: params[:card_id])
  @round = Round.find_by(user_id: session[:session_id])
  @guess = Guess.find_by(round_id: @round.id, card_id: params[:card_id])
  erb :'/card/show'
end

# This route does not serve a purpose.  All it does is call the database and then
# redirect away.  Ultimately, it just takes up time.
post '/deck/:deck_id/card/:card_id' do
  @cards = Card.where(deck_id: params[:deck_id])
  redirect "/deck/#{params[:deck_id]}/card/#{params[:card_id]}"
end

get '/deck/:deck_id/play' do
  @deck = Deck.find_by(id: params[:deck_id])
  # @cards = @deck.cards
  @cards = Card.where(deck_id: params[:deck_id])
  @round = Round.last # There is absolutely no guarantee that this is the round you
  # are looking for.  This is just the last round that was created.
  # Maybe:
  # @round = current_user.rounds.last # note we are using the association on the user object
  @guess = Guess.where(round_id: @round.id)
  @counter = 0
  # binding.pry
  erb :'deck/play'
end

# I envision the routing flow for playing the game to look like:
#
# GET '/rounds/:round_id/next_card'
#       ||
# POST '/rounds/:round_id/cards/:card_id/guesses'
# POST '/guesses' (this would require hidden fields for round_id and card_id)
#        ||
# redirect to->
# GET '/rounds/:round_id/next_card'
#
# Logic in the next_card route may be:
#
# get '/rounds/:round_id/next_card' do
#   @round = Round.find_by(id: params[:round_id])
#   if @round.next_card
#     erb "cards/show"
#   else
#     erb "rounds/stats"
#   end
# end

# So ultimately, you never appear to check if the user has answered correctly.  Honor
# system flashcards is an easy game to win.

# This route is not restul.  This route infers you are making a new Play object, associated to a Deck.
# I think what we want is:
#
# post '/rounds/:round_id/cards/:card_id/guesses'
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
