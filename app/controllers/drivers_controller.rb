class DriversController < ApplicationController
	include DriversHelper

	def index
		@drivers = Driver.ordered_by_name.page(params[:page]).per_page(10)
	end

	def show
		@driver = Driver.find(params[:id])
	end

	def new
		@driver = Driver.new
	end

	def create
		@driver = Driver.new(driver_params)
		if @driver.save
			flash[:success] = "New driver added!"
			render 'shared/thankyou'
		else
			render 'new'
		end
	end

	def destroy
		Driver.find(params[:id]).destroy
    flash[:success] = "Driver deleted"
    redirect_to drivers_url
	end

	private
		def driver_params
			params.require(:driver).permit(:name, :email, :phone, :address, :car_spots)
		end
end
