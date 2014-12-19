class AgencyMailer < ApplicationMailer

	def send_message(name, email, message, gym)
		@message = message
		@gym = Gym.find(gym)
		@name = name
		@email = email
		mail(to: @gym.agency.email, from: "GymExplore <#{email}>", subject: "New Enquiry about your Gym - gYmExplore.com")
	end

end
