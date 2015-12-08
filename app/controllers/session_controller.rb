post '/sessions' do
 user = User.find_by(username: params[:username])
  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect '/flashcards/index'
  else
    redirect '/?errors=incorrect_user_or_password'
    ## Incorrect username or password
  end
end

get '/sessions/new' do
  erb :'/sessions/new'
end

# This route belongs in the users_controller.
# Proper route for creating a User:
#
# post '/users'
# get '/users/:id'
# get '/users/new'
post '/sessions/create' do
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect '/flashcards/index'
  else
    erb :'/sessions/new', locals: { errors: user.errors.full_messages }
  end
end
