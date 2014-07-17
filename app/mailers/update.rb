class Update < ActionMailer::Base
   default from: "\"Brew Garden\" <hello@brewgarden.com>"


   def update_email(project, update)
   	@project = project
   	@update = update
   	project.pledges.each do |pledge|
    	mail(to: pledge.user.email, subject: "#{project.title} has posted an update!")
   end
end
