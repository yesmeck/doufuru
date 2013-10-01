module Doufuru

  # Authentication methods for {Doufuru::Client}
  module Authentication

    # Indicates if the client was supplied an OAuth access token
    #
    # @return [Boolean]
    def token_authenticated?
      !!@access_token
    end

    # Indicates if the client was supplied an OAuth access token
    #
    # @return [Boolean]
    def user_authentication?
      token_authenticated?
    end

    # Indicates if the client has OAuth apllication
    # client_id and secret credentials to make anonymous
    # resquets at a highet limit
    #
    # @return [Boolean]
    def application_authenticated?
      !!application_authentication
    end

    private

    def application_authentication
      { client_id: @client_id, client_secret: @client_secret }  if @client_id && @client_secret
    end

  end

end
