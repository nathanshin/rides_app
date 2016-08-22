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
		
		deserialize_drivers
		deserialize_riders
		assign_riders_to_drivers
	end
	
	# Maybe change the implementation to map?
	def deserialize_drivers
		@included_drivers.each do |included_driver|
			driver = YAML::load(included_driver)
			@drivers << driver
		end
	end

	def deserialize_riders
		@included_riders.each do |included_rider|
			rider = YAML::load(included_rider)
			@riders << rider
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
					assigned_riders << @riders.shift
				else
					break
				end
			end
			@assignment.assignments << {name: driver.name, riders: assigned_riders}
		end

		# If there are riders left after assignment, put them in a "Riders Remaining" slot
		if !@riders.empty?
			riders_remaining = {name: "Riders Remaining", riders: @riders }
			@assignment.assignments << riders_remaining
		end
	end
end
