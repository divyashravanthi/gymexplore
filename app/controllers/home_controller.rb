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

	def unverified_gyms
		@gyms = Gym.where(:verified => false)
	end

	def sitemap
	    path = Rails.root.join("public", "sitemaps", "sitemap.xml")
	    if File.exists?(path)
	      render xml: open(path).read
	    else
	      render text: "Sitemap not found.", status: :not_found
	    end
	end

	def robots
		respond_to :text
	end
end
