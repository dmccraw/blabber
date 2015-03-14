class TokensController < ApplicationController
  def request_token
    request_token = TWITTER.get_request_token(oauth_callback: ENV['OAUTH_CALLBACK'])
    Oauth.create(token: request_token.token, secret: request_token.secret)
    redirect_to request_token.authorize_url(oauth_callback: ENV['OAUTH_CALLBACK'])
  end

  def access_token
    oauth = Oauth.find_by(token: params[:oauth_token])
    if oauth.present?
      request_token = OAuth::RequestToken.new(TWITTER, oauth.token, oauth.secret)
      access_token = request_token.get_access_token(oauth_verifier: params[:oauth_verifier])
      redirect_to client_token_path(uid: access_token.params[:user_id], handle: access_token.params[:screen_name])
    else
      redirect_to ENV['ORIGIN']
    end
  end

  def client_token
    # pass in a block so that you can update the handle of the user if it already exists
    user = User.find_or_create_by(uid: params[:uid]) { |u| u.handle = params[:handle] }
    jwt = JWT.encode({uid: user.uid, exp: 1.day.from_now.to_i}, Rails.application.secrets.secret_key_base)
    redirect_to "#{ENV['ORIGIN']}?jwt=#{jwt}"
  end
end