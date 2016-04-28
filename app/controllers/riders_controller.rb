class RidersController < ApplicationController
	def new
		@rider = Rider.new
	end

	def create
		@rider = Rider.new(rider_params)
		if @rider.save
			render 'shared/thankyou'
		else
			render 'new'
		end
	end

	private
		def rider_params
			params.require(:rider).permit(:name, :email, :phone, :address)
		end
end
