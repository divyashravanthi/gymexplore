class ReviewsController < ApplicationController

	skip_before_filter :verify_authenticity_token, :only => [:create]

	def create
		@review = Review.create(:name => params[:name], :comment => params[:comment], :rating => params[:rating], :gym_id => params[:gym_id])
		render :layout => false
	end

end
