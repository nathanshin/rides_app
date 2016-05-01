class DriversController < ApplicationController
	before_action :authenticate_admin!, only: [:destroy]
	
	include DriversHelper

	def index
		@drivers = Driver.ordered_by_name
		# .page(params[:page]).per_page(10)
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
			if admin_signed_in?
				redirect_to drivers_path
			else
				redirect_to thankyou_path
			end
		else
			render 'new'
		end
	end

	def edit
		@driver = Driver.find(params[:id])
	end

	def update
    @driver = Driver.find(params[:id])
    if @driver.update_attributes(driver_params)
      flash[:success] = @driver.name + " has been updated!"
      redirect_to drivers_path
    else
      render 'edit'
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
