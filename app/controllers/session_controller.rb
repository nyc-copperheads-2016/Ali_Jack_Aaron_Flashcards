post '/sessions' do
 user = User.find_by(username: params[:username])
  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect '/index'
  else
    redirect '/?errors=incorrect_user_or_password'
    ## Incorrect username or password
  end
end

