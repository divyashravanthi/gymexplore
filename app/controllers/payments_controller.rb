class PaymentsController < ApplicationController

	skip_before_filter :verify_authenticity_token, :only => [:success, :failure]

	def make_payment
		@gym = Gym.find(params[:gym_id])
		@plan = @gym.pricings.find(params[:plan])
		@name = params[:name]
		@mobile = params[:phone]
		@email = params[:email]
		@txnid = rand(1..420000)
		@productinfo = Hash.new
		@productinfo["paymentParts"] = Array.new
		@productinfo["paymentParts"][0] = Hash.new
		@productinfo["paymentParts"][0]["name"] = @gym.name
		@productinfo["paymentParts"][0]["description"] = @gym.description
		@productinfo["paymentParts"][0]["value"] = @plan.price.to_s
		@productinfo["paymentParts"][0]["isRequired"] = "true"
		@productinfo["paymentParts"][0]["settlementEvent"] = "EmailConfirmation"
		@udf1 = @gym.id
		@udf2 = @plan.id
		@hash = Digest::SHA512.hexdigest("JBZaLc|#{@txnid}|#{@plan.price}|#{@productinfo}|#{@name}|#{@email}|#{@udf1}|#{@udf2}|||||||||GQs7yium")
	end

	def success
		hash = Digest::SHA512.hexdigest("GQs7yium|#{params[:status]}|||||||||#{params[:udf2]}|#{params[:udf1]}|#{params[:email]}|#{params[:firstname]}|#{params[:productinfo]}|#{params[:amount]}|#{params[:txnid]}|JBZaLc")
		if hash == params[:hash]
			if params[:status] == "success"
				Payment.create(:mihpayid => params[:mihpayid],:mode => params[:mode],:status => params[:status],:txnid => params[:txnid],:firstname => params[:firstname],:email => params[:email],:phone => params[:phone],:gym_id => params[:udf1].to_i,:plan_id => params[:udf2].to_i,:payuMoneyId => params[:payuMoneyId])
				@gym = Gym.find(params[:udf1])
				@plan = @gym.pricings.find(params[:udf2])
				@name = params[:firstname]
				@email = params[:email]
				@mobile = params[:phone]
			else
				redirect_to root_path, :notice => params[:error_Message]
			end
		else
			redirect_to root_path, :notice => "Something Went Wrong"
		end
	end

	def failure
		redirect_to root_path, :notice => "Something Went Wrong"
	end

end
