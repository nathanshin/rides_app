require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
	def setup
		@assignment = Assignment.new(event: "ACTS Sunday", 
																 date: "2016-02-08", 
																 included_drivers: ["Nathan Shin", "Sojung Uhm"], 
																 included_riders: ["Nathan Shin", "Sojung Uhm", "David Kim", "Daniel Chang", "Brian Shin", "Joseph Hurh"])
	end

	test "assignment should be valid" do
		assert @assignment.valid?
	end	

	test "event name should be present" do
		@assignment.event = "    "
		assert_not @assignment.valid?
	end

	test "date should be present" do
		@assignment.date = "   "
		assert_not @assignment.valid?
	end

	test "assignments should get created upon save" do
		@assignment.arrange_rides
		@assignment.save
		assert_not @assignment.assignments.nil?
	end
end

