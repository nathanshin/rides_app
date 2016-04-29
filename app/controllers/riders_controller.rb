class RidersController < ApplicationController
	def index
		@riders = Rider.ordered_by_name.page(params[:page]).per_page(15)
	end

	def show
		@rider = Rider.find(params[:id])
	end

	def new
		@rider = Rider.new
	end

	def create
		@rider = Rider.new(rider_params)
		if @rider.save
			flash[:success] = "New rider added!"
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
