class ApplicationController < ActionController::Base

  protect_from_forgery

  private

  before_filter :setup
  def setup
    @signed_in = user_signed_in?

    if @signed_in
      @candidate_authenticated = NbecToken.exists? :user_id => current_user.id
    end
  end

end
