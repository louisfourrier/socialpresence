class SessionsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    service = Service.from_omniauth(env['omniauth.auth'], current_user)
  end
end
