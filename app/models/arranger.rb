class Arranger
	def initialize(assignment)
		@assignment = assignment
		@included_drivers = assignment.included_drivers
		@included_riders = assignment.included_riders
	end

	def arrange_rides
		@drivers = []
		@riders = []
		@assignment.assignments = []
		
		pull_drivers_from_database
		pull_riders_from_database
		assign_riders_to_drivers
	end

	# Maybe change the implementation to map?
	def pull_drivers_from_database
		@included_drivers.each do |included_driver|
			if (driver = Driver.find_by(name: included_driver))
				@drivers << driver
			end
		end
	end

	def pull_riders_from_database
		@included_riders.each do |included_rider|
			if (rider = Rider.find_by(name: included_rider))
				@riders << rider
			end
		end
	end

	def assign_riders_to_drivers
		@drivers.each do |driver|

			# Create a list of riders ordered by distance to drivers
			@riders.each do |rider|
				rider.distance_to_driver = driver[:geocode].distance_to(rider[:geocode])
			end
			@riders = @riders.sort_by { |rider| rider.distance_to_driver }

			# Pulls driver[:spots] number of rider OUT of the list and assigns to driver
			assigned_riders = []
			driver[:car_spots].to_i.times do
				if !@riders.empty?
					assigned_riders << @riders.shift[:name]
				else
					break
				end
			end
			@assignment.assignments << {name: driver.name, riders: assigned_riders}
		end

		# If there are riders left after assignment, put them in a "Riders Remaining" slot
		if !@riders.empty?
			riders_remaining = {name: "Riders Remaining", riders: @riders.map {|rider| rider.name} }
			@assignment.assignments << riders_remaining
		end
	end
end
