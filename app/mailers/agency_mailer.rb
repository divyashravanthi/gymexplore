class AgencyMailer < ApplicationMailer

	def send_message(name, email, message, gym)
		@message = message
		@gym = Gym.find(gym)
		mail(to: @gym.agency.email, from: "'#{name}' <#{email}>", subject: "New Enquiry about your Gym - gYmExplore.com")
	end

end
