class AssignmentsController < ApplicationController
	before_action :authenticate_admin!, only: [:new, :create, :destroy]

	def index
		@assignments = Assignment.ordered_by_date.page(params[:page]).per_page(5)
	end

	def show
		@assignment = Assignment.find(params[:id])
	end

	def new
		@drivers = Driver.ordered_by_name
		@riders = Rider.ordered_by_name
		@assignment = Assignment.new
	end

	def create 
		@drivers = Driver.all
		@riders = Rider.all
		@assignment = Assignment.new(assignment_params)
		if @assignment.save
			redirect_to @assignment
		else
			render 'new'
		end
	end

	def destroy
		Assignment.find(params[:id]).destroy
    flash[:success] = "Driver deleted"
    redirect_to assignments_url
	end
	
	private
		def assignment_params
			params.require(:assignment).permit(:event, :date, :location, {:included_drivers => []}, {:included_riders => []})
		end
end

