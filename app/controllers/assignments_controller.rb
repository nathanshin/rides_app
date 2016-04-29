class AssignmentsController < ApplicationController
	def index
		@assignments = Assignment.ordered_by_date.page(params[:page]).per_page(5)
	end

	def show
		@assignment = Assignment.find(params[:id])
	end

	def new
		@drivers = Driver.all
		@riders = Rider.all
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
	
	private
		def assignment_params
			params.require(:assignment).permit(:event, :date, {:included_drivers => []}, {:included_riders => []})
		end
end

