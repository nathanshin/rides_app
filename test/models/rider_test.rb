require 'test_helper'

class RiderTest < ActiveSupport::TestCase
	def setup
		@rider = Rider.new(name: "Nathan Shin",
												 email: "nathanshin@utexas.edu",
												 phone: "214-930-8918",
												 address: "911 W 21st St, Austin, TX 78705")
	end

  test "should be valid" do
		assert @rider.valid?
	end

	test "name should be present" do
		@rider.name = "    "
		assert_not @rider.valid?
	end

	test "email should be present" do
		@rider.email = "   "
		assert_not @rider.valid?
	end

	test "phone should be present" do
		@rider.phone = "    "
		assert_not @rider.valid?
	end

	test "address should be present" do
		@rider.address = "   "
		assert_not @rider.valid? 
	end

	test "name should not be too long" do
		@rider.name = "a" * 51
		assert_not @rider.valid?
	end


	test "email should not be too long" do
		@rider.email = "a" * 244 + "@example.com"
		assert_not @rider.valid?
	end

	test "email validation should accept valid addresses" do 
		valid_addresses = %w[nathanshin@example.com nate+soj@utexas.edu usdh-bsd@foo.bar first.last@example.ORG]
		valid_addresses.each do |valid_address|
			@rider.email = valid_address
			assert @rider.valid?, "#{valid_address.inspect} should be valid"
		end
	end

	test "email validation should reject invalid addresses" do 
		invalid_addresses = %w[rider@example,com rider_at_foo.org rider.name@example.
                           foo@bar_baz.com foo@bar+baz.com nathanshin@utexas..edu]
    invalid_addresses.each do |invalid_address|
    	@rider.email = invalid_address
    	assert_not @rider.valid?, "#{invalid_address.inspect} should be invalid"
    end
	end

	test "email address should be unique" do
		duplicate_rider = @rider.dup
		duplicate_rider.email = @rider.email.upcase
		@rider.save
		assert_not duplicate_rider.valid?
	end

	test "email address should be saved as downcase" do
		mixed_case_email = "NaTHANsHin@UTexaS.edU"
		@rider.email = mixed_case_email
		@rider.save
		assert_equal mixed_case_email.downcase, @rider.reload.email
	end

	test "geocode should get assigned following proper save" do
		@rider.save
		assert_not @rider.geocode.nil?
	end

end
