# encoding: UTF-8
# ApplicationController to define main Controller class
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
end
