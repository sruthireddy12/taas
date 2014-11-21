class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user, password)
    @user = user
    @password = password
    mail(:to => @user.email, :subject => "Welcome to TaasPro")
  end


  def update(user, password)
    @user = user
    @password = password
    mail(:to => @user.email, :subject => "Your TaasPro Account Changed")
  end
end
