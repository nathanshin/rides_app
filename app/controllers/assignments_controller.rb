class AssignmentsController < ApplicationController
	def index
		@assignments = Assignment.order('date DESC').page(params[:page]).per_page(4)
	end

	def show
		@assignment = Assignment.find(params[:id])
	end

	def new
		@assignment = Assignment.new
		@drivers = Driver.all
		@riders = Rider.all
	end

	def create 
		@assignment = Assignment.new(assignment_params)
		@assignment.arrange_rides
		if @assignment.save
			redirect_to assignments_path
		else
			render 'new'
		end
	end

	private
		def assignment_params
			params.require(:assignment).permit(:event, :date, {:included_drivers => []}, {:included_riders => []})
		end
end
