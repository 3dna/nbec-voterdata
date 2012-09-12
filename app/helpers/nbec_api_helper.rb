module NbecApiHelper

  module APIHelpers

    def get_voter_status
      api_url = "#{NbecToken.settings[:site]}/api/v1/candidate/current"
      response = @nbec_access_token.get(api_url) unless @nbec_access_token.nil?
      response.body if response
    end

    def get_voter_data_from_url(access_token, url)
      api_response = access_token.get(url)
      api_response.body
    end
  end

  # Mock API helpers for testing. Don't do this with a real app.
  module MockAPIHelpers

    def get_voter_status
      {
        "candidate" => {
          "voter_data_status" => "ready",
          "voter_data_url" => "example-url.com"
        }
      }.to_json
    end

    def get_voter_data_from_url(access_token, url)
      CSV.generate do |csv|
        csv << ["voter_id", "first_name", "last_name", "email"]
        csv << [1, "Test", "User", "example@email.com"]
      end
    end

  end

end
