require 'test_helper'

class DriverTest < ActiveSupport::TestCase
	def setup
		@driver = Driver.new(name: "Nathan Shin",
												 email: "nathanshin@utexas.edu",
												 phone: "214-930-8918",
												 address: "911 W 21st St, Austin, TX 78705",
												 car_spots: "3")
	end

  test "should be valid" do
		assert @driver.valid?
	end

	test "name should be present" do
		@driver.name = "    "
		assert_not @driver.valid?
	end

	test "email should be present" do
		@driver.email = "   "
		assert_not @driver.valid?
	end

	test "phone should be present" do
		@driver.phone = "    "
		assert_not @driver.valid?
	end

	test "address should be present" do
		@driver.address = "   "
		assert_not @driver.valid? 
	end

	test "car_spots should be present" do
		@driver.car_spots = "   "
		assert_not @driver.valid?
	end


	test "name should not be too long" do
		@driver.name = "a" * 51
		assert_not @driver.valid?
	end


	test "email should not be too long" do
		@driver.email = "a" * 244 + "@example.com"
		assert_not @driver.valid?
	end

	test "email validation should accept valid addresses" do 
		valid_addresses = %w[nathanshin@example.com nate+soj@utexas.edu usdh-bsd@foo.bar first.last@example.ORG]
		valid_addresses.each do |valid_address|
			@driver.email = valid_address
			assert @driver.valid?, "#{valid_address.inspect} should be valid"
		end
	end

	test "email validation should reject invalid addresses" do 
		invalid_addresses = %w[driver@example,com driver_at_foo.org driver.name@example.
                           foo@bar_baz.com foo@bar+baz.com nathanshin@utexas..edu]
    invalid_addresses.each do |invalid_address|
    	@driver.email = invalid_address
    	assert_not @driver.valid?, "#{invalid_address.inspect} should be invalid"
    end
	end

	test "email address should be unique" do
		duplicate_driver = @driver.dup
		duplicate_driver.email = @driver.email.upcase
		@driver.save
		assert_not duplicate_driver.valid?
	end

	test "geocode should get assigned following proper save" do
		@driver.save
		assert_not @driver.geocode.nil?
	end
end
