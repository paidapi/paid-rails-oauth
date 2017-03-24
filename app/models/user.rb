# encoding: UTF-8
# User model that is used for Authentication
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:paid_connect],
                        authentication_keys: [:uid]

  validates :uid, presence: true,
                  uniqueness: {
                    case_sensitive: false
                  }

  def self.from_omniauth(access_token = {})
    User.find_existing(access_token) ||
      User.create(User.get_omniauth_details(access_token))
  end

  def self.find_existing(access_token = {})
    User.find_or_initialize_by(uid: access_token.fetch('uid'))
        .tap { |u| u.update!(User.get_omniauth_details(access_token)) }
  end

  def self.get_omniauth_details(access_token = {})
    credentials = access_token.fetch('credentials', {})
    {
      uid: access_token.fetch('uid'),
      provider: access_token.fetch('provider'),
      password: Devise.friendly_token,
      token: credentials.fetch('token', ''),
      refresh_token: credentials.fetch('refresh_token', '')
    }
  end

  def access_token
    @access_token ||= OAuth2::AccessToken.from_hash(client, access_token_params)
  end

  def client
    @client ||= OAuth2::Client.new(
      Rails.application.secrets.paid_app_id,
      Rails.application.secrets.paid_secret,
      site: 'https://api.paidlabs.com'
    )
  end

  def access_token_params
    @access_token_params ||= {
      access_token: token,
      refresh_token: refresh_token,
      scope: 'read_only',
      livemode: false,
      token_type: 'bearer'
    }
  end

  def email_required?
    false
  end
end
