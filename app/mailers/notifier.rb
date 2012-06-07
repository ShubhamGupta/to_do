class Notifier < ActionMailer::Base
  default from: "sgupta.89cse@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.registered.subject
  #
  def registered(user)
    @greeting = "Hi"
		@user = user
    mail(:to => @user.email_id, :subject => "You are now registered!")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.reminder.subject
  #
#  def reminder
#    @greeting = "Hi"

#    mail to: "to@example.org"
#  end
end
