class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  respond_to :html
  def show
    @messages = @service.messages.order('created_at DESC').limit(5)
    respond_with(@service)
  end

  def edit
  end

  def update
    @service.update(service_params)
    respond_with(@service)
  end

  def destroy
    @service.destroy
    respond_with(@service)
  end

  private

  def set_service
    @service = current_user.services.find_by_id(params[:id])
    if !@service
      flash[:notice] = "Ce service n'est pas reconnu"
      redirect_to current_user
    end
  end

  def service_params
    params.require(:service).permit(:name, :tags, :automatic_follow, :email_alert)
  end
end
