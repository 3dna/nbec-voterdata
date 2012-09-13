class NbecToken < ConsumerToken

  NBEC_SETTINGS = {
    site: "https://elections.nationbuilder.com",
    request_token_path: "/oauth/request_token",
    access_token_path: "/oauth/access_token",
    authorize_path: "/oauth/authorize"
  }

  def self.consumer(options={})
    @consumer ||= OAuth::Consumer.new(credentials[:key],
                                      credentials[:secret],
                                      NBEC_SETTINGS.merge(options))
  end

  def self.settings
    NBEC_SETTINGS
  end
end
