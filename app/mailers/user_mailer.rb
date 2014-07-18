class UserMailer < ActionMailer::Base
  default from: "\"Brew Garden\" <hello@brewgarden.com>"

  def reset_password_email(user)
    @user = user
    @url = edit_password_reset_url(user.reset_password_token)
    @greeting = "Hi"

    mail to: user.email, subject: "Please reset password." 
  end

   def update_email(project, update)
    @project = project
    @update = update
    project.pledges.each do |pledge|
      mail to: pledge.user.email, subject: "#{project.title} has posted an update!"
    end
   end

   def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to the BREW GARDEN')
  end
end
