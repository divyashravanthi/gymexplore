class AgencyMailer < ApplicationMailer

	def send_message(name, email, message, gym)
		@message = message
		@gym = gym
		@name = name
		@email = email
		mail(to: @gym.email, from: "GymExplore <#{email}>", subject: "New Enquiry about your Gym - GymExplore.com")
	end

	def write_to_us(email, message)
		@message = message
		@email = email
		mail(to: 'ankitsamar@outlook.com', from: email, subject: "Query from #{email} - GymExplore.com")
	end

end
