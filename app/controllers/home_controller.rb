class HomeController < ApplicationController

	layout 'website'

	def index
	end

	def privacy
	end

	def terms
	end

	def write
		AgencyMailer.write_to_us(params[:email], params[:message]).deliver_now
	end
end
