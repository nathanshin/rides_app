class Arranger
	def initialize(assignment)
		@assignment = assignment
		@assignment.assignments = []
		@drivers = []
		@riders = []
		@included_drivers = assignment.included_drivers
		@included_riders = assignment.included_riders
	end

	def arrange_rides
		pull_drivers_from_database
		pull_riders_from_database
		assign_riders_to_drivers
	end

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
			assignments = {name: driver.name, riders: assigned_riders}
			@assignment.assignments << assignments
		end
	end
end
