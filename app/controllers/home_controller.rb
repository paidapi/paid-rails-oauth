# encoding: UTF-8
# ApplicationController to define main Controller class
class HomeController < ApplicationController
  def index
    @invoices = current_user.access_token.get('/v0/invoices')
                            .parsed.fetch('data')
  end
end
