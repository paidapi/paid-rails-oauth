# encoding: UTF-8
module OmniAuth
  module Strategies
    # PaidConnect strategy for Omniauth
    class PaidConnect < OmniAuth::Strategies::OAuth2
      option :name, :paid_connect

      option :client_options, site: 'https://auth.paidlabs.com'

      option :provider_ignores_state, true

      uid { account.fetch(:id) }

      info do
        {
          params: params,
          account: account
        }
      end

      credentials do
        {
          token: access_token.token,
          refresh_token: access_token.refresh_token,
          expires: access_token.expires?,
          expires_at: access_token.expires? ? access_token.expires_at : nil
        }
      end

      def params
        @params ||= deep_symbolize(access_token.params)
      end

      def account
        @account ||= deep_symbolize(access_token.get('https://api.paidlabs.com/v0/account').parsed)
      end
    end
  end
end
