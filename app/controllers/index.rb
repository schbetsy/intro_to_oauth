get '/' do
  @user = User.find(session[:user_id]) if session[:user_id]
  if @user
    tweeter = Twitter::Client.new(oauth_token: @user.oauth_token, oauth_token_secret: @user.oauth_secret)
    @recent_tweets = tweeter.user_timeline(@user.username, {count: 5})
  end
  erb :index
end

get '/sign_in' do
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

  session[:user_id] = @user.id

  redirect to '/'
end

post '/status/:job_id' do
  status = job_is_complete(params[:job_id])
  return status.to_s
end

post '/submit_tweet' do 
  user = User.find(session[:user_id])
  user.tweet(params[:tweet])
  # redirect to "/"
end
