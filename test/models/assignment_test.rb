require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
	def setup
		@assignment = Assignment.new(event: "ACTS Sunday", 
																 date: "2016-02-08", 
																 included_drivers: ["Nathan Shin"], 
																 included_riders: ["Sojung Uhm"])
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

	test "at least 1 driver should be checked" do
		@assignment.included_drivers = []
		assert_not @assignment.valid?
	end

	test "at least 1 rider should be checked" do
		@assignment.included_riders = []
		assert_not @assignment.valid?
	end

	test "assignments should get created upon save" do
		@assignment.arrange_rides
		@assignment.save
		assert_not @assignment.assignments.nil?
	end
end

