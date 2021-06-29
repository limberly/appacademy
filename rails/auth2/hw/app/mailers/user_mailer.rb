class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def welcome_email(user)
    @user = user
    @url = new_user_url
    mail(to: 'limhyungue@gmail.com', subject: 'Welcome to the 99 cats!')
    
  end
end
