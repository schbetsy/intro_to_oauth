get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)

  @user = User.new
  @user.username = @access_token.params[:screen_name]
  @user.oauth_token = @access_token.token
  @user.oauth_secret = @access_token.secret
  @user.save

  # at this point in the code is where you'll need to create your user account and store the access token

  erb :index
  
end

post '/submit_tweet' do 
  p session
  # Twitter.update(params[:tweet])
  # redirect to "/"
end
