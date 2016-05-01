require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "invalid driver signup renders 'new' page" do
  	get new_driver_path
  	assert_no_difference 'Driver.count' do
			post drivers_path, driver: { name: '',
															 		 email: 'user@foo',
																	 phone: 'a23423',
																	 address: '1',
																	 car_spots: '4'}
		end
		assert_template 'drivers/new'
  end

   test "invalid rider signup renders 'new' page" do
  	get new_rider_path
  	assert_no_difference 'Rider.count' do
			post riders_path, rider: { name: '',
															 	 email: 'user@foo',
																 phone: 'a23423',
																 address: '1'}
			end
		assert_template 'riders/new'
  end

	test "valid driver signup information renders thank you page" do
		get new_driver_path
		assert_difference 'Driver.count', 1 do
			post_via_redirect drivers_path, driver: { name: 'Nate Shin',
																							  email: 'nate@nate.com',
																						  	phone: '214-930-8918',
																						  	address: '911 W 21st St, Austin, TX 78705',
																						  	car_spots: '3' }
		end
		assert_template 'user_signups/thankyou'
		assert_select 'h1', "Thank you!"
	end

	test "valid rider signup information shows thank you page" do
		get new_rider_path
		assert_difference 'Rider.count', 1 do
			post_via_redirect riders_path, rider: { name: 'Nate Shin',
																						  email: 'nate@nate.com',
																					  	phone: '214-930-8918',
																					  	address: '911 W 21st St, Austin, TX 78705' }
		end
		assert_template 'user_signups/thankyou'
		assert_select 'h1', "Thank you!"
	end
end
