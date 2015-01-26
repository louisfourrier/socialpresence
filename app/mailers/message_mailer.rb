class MessageMailer < ActionMailer::Base
  default from: "server@socialpresence.com"
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.new_message.subject
  #
  def new_message(user, message)
    @user = user
    @message = message
    @service = @message.service
    mail(to: @user.email, subject: 'New message sent through SocialPresence')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.test.subject
  #
  def test
    @greeting = "Hi"
     mail(to: "louis.fourrier@gmail.com", subject: 'Test mail from development socialpresence')
  end
end
