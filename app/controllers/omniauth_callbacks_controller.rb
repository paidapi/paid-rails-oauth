# encoding: UTF-8
# OmniauthCallbacksController that handles omniauth callbacks
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def paid_connect
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = t 'devise.omniauth_callbacks.success', kind: 'Paid'
      sign_in_and_redirect(@user, event: :authentication)
    else
      flash[:error] = t 'devise.omniauth_callbacks.failure', kind: 'Paid',
                                                             reason: ''
      redirect_to new_user_session_path
    end
  end
end
