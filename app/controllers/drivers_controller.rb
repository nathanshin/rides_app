class DriversController < ApplicationController
	include DriversHelper

	def new
		@driver = Driver.new
	end

	def create
		@driver = Driver.new(driver_params)
		if @driver.save
			render 'shared/thankyou'
		else
			render 'new'
		end
	end

	private
		def driver_params
			params.require(:driver).permit(:name, :email, :phone, :address, :car_spots)
		end
end
