class PersistDataController < ApplicationController

  def page_title
    "Persist voter data"
  end

  def index
    unless @signed_in
      show_error_message "Please sign in or register to access voter data."
      return
    end

    api_response = get_voter_status

    if api_response.nil?
      show_error_message
      return
    end

    @content = ActiveSupport::JSON.decode(api_response)

    if @content["candidate"]["voter_data_status"] == "ready"
      @show_download_button = true
      @download_url = @content["candidate"]["voter_data_url"]
    elsif @content["candidate"]["voter_data_status"] == "processing"
      show_error_message "Your voter data is currently being processed. Please check again later."
    else
      show_error_message
    end
  end

  def create
    download_url = params[:download_url]

    if download_url.nil?
      redirect_to :index
    end

    content = get_voter_data_from_url(@nbec_access_token,
                                      download_url)

    @num_created = Voter.import_voters_from_csv(content)

    render :create
  end

  private

  # A hack to facilitate OAuth testing.
  if Rails.env == "test"
    include NbecApiHelper::MockAPIHelpers
  else
    include NbecApiHelper::APIHelpers
  end

  before_filter :initialize_download
  def initialize_download
    @current_user = current_user

    if @current_user and @current_user.nbec
      @nbec_access_token = @current_user.nbec.client
    end
  end

  def show_error_message(message="Voter data is currently unavailable.")
    @show_download_button = false
    flash.now[:error] = message
  end

end
