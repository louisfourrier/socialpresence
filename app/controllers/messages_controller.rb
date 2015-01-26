class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_service
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  respond_to :html
  
  def index
    @messages = @service.messages.order('created_at DESC')
    respond_with(@messages)
  end

  def show
    respond_with(@service, @message)
  end

  def new
    @message = @service.messages.build()
    respond_with(@service, @message)
  end

  def edit
  end

  def create
    @message = @service.messages.build(message_params)
    @message.save
    respond_with(@service, @message)
  end

  def update
    @message.update(message_params)
    respond_with(@service, @message)
  end

  def destroy
    @message.destroy
    respond_with(@service, @message)
  end

  private

  def get_service
    @service = current_user.services.find_by_id(params[:service_id])
    if !@service
      flash[:notice] = "Ce service n'est pas reconnu"
      redirect_to current_user
    end
  end

  def set_message
    @message = @service.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:service_id, :service_token, :content, :url, :from_url, :tags)
  end
end
