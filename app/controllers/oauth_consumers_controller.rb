require 'oauth/controllers/consumer_controller'

class OauthConsumersController < ApplicationController
  include Oauth::Controllers::ConsumerController

  before_filter :authenticate_user!, :only=>:index

  def index
    @consumer_tokens = ConsumerToken.all(conditions: { user_id: current_user.id })
    @services = OAUTH_CREDENTIALS.keys - @consumer_tokens.collect{ |c| c.class.service_name }
  end

  def callback
    super
  end

  def client
    super
  end

  protected

  def go_back
    redirect_to root_url
  end

  def deny_access!
    flash[:error] = "Could not authenticate using OAuth."
    go_back
  end

  def current_user=(user)
    sign_in(user)
  end

  def logged_in?
    user_signed_in?
  end

  def go_back
    redirect_to root_url
  end

end
