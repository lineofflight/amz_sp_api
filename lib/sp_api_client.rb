require 'api_error'
require 'api_client'

module AmzSpApi
  class SpApiClient < ApiClient
    def initialize(config = SpConfiguration.default)
      @grantless = false
      super(config)
    end

    alias super_call_api call_api
    def call_api(http_method, path, opts = {})
      super(http_method, path, opts.merge(header_params: auth_headers.merge(opts[:header_params] || {})))
    end

    def grantless
      dup.tap { |c| c.instance_variable_set(:@grantless, true) }
    end

    private

    def retrieve_lwa_access_token
      return request_lwa_access_token[:access_token] unless config.get_access_token
      stored_token = config.get_access_token.call(config.access_token_key)
      if stored_token.nil?
        new_token = request_lwa_access_token
        config.save_access_token&.call(config.access_token_key, new_token)
        return new_token[:access_token]
      else
        return stored_token
      end
    end

    def request_lwa_access_token
      newself = self.dup
      newself.config = config.dup
      newself.config.host = 'api.amazon.com'

      data, status_code, headers = newself.super_call_api(:POST, '/auth/o2/token',
        header_params: {
          'Content-Type' => 'application/x-www-form-urlencoded'
        },
        form_params:  lwa_access_token_params,
        return_type: 'Object')

      unless data && data[:access_token]
        fail ApiError.new(:code => status_code,
                          :response_headers => headers,
                          :response_body => data)
      end

      data
    end

    def lwa_access_token_params
      if @grantless
        {
          grant_type: 'client_credentials',
          scope: 'sellingpartnerapi::notifications',
          client_id: config.client_id,
          client_secret: config.client_secret
        }
      else
        {
          grant_type: 'refresh_token',
          refresh_token: config.refresh_token,
          client_id: config.client_id,
          client_secret: config.client_secret
        }
      end
    end

    def auth_headers
      { 'x-amz-access-token' => retrieve_lwa_access_token }
    end
  end
end
