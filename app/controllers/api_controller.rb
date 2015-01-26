class ApiController < ApplicationController
  def newmessage
    service_token = params[:service_token]
    if service_token.nil?
      return
    end
    service = Service.find_by(service_token: service_token)
    if service.nil?
      return
    end
    Message.create_from_api(params[:message], service)
  end
end
