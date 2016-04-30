class RidersController < ApplicationController
	before_action :authenticate_admin!, only: [:destroy]

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

	def destroy
		Rider.find(params[:id]).destroy
    flash[:success] = "Rider deleted"
    redirect_to riders_url
	end

	private
		def rider_params
			params.require(:rider).permit(:name, :email, :phone, :address)
		end
end
