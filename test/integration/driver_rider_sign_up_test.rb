require 'test_helper'

class DriverRiderSignUpTest < ActionDispatch::IntegrationTest
	
	test "invalid driver signup renders new" do
		get new_driver_path
		assert_template 'drivers/new'
		assert_no_difference 'Driver.count' do
			post_via_redirect drivers_path, driver: { name: '   ',
																								email: 'nate@nate',
																								phone: '214-930-8918',
																							  address: '911 W 21st St, Austin, TX 78705',
																								car_spots: ' ' }
		end
	end

	test "invalid rider signup renders new" do
		get new_rider_path
		assert_template 'riders/new'
		assert_no_difference 'Rider.count' do
			post_via_redirect riders_path, rider: { name: '   ',
																							email: 'nate@nate',
																							phone: '214-930-8918',
																						  address: '911 W 21st St, Austin, TX 78705'}
		end
	end

  test "Signed up driver shows up in new assignment page" do
		get new_driver_path
		assert_template 'drivers/new'
		assert_difference 'Driver.count', 1 do
			post_via_redirect drivers_path, driver: { name: 'Nate Shin',
																								email: 'nate@nate.com',
																								phone: '214-930-8918',
																							  address: '911 W 21st St, Austin, TX 78705',
																								car_spots: '3' }
		end
		assert_template 'shared/thankyou'
		assert_select 'div.alert', "New driver added!"
		get new_assignment_path
		assert_select 'input[value="Nate Shin"]'
	end

	test "Signed up rider shows up in new assignment page" do
		get new_rider_path
		assert_template 'riders/new'
		assert_difference 'Rider.count', 1 do
			post_via_redirect riders_path, rider: { name: 'Nate Shin',
																							email: 'nate@nate.com',
																							phone: '214-930-8918',
																						  address: '911 W 21st St, Austin, TX 78705'}
		end
		assert_template 'shared/thankyou'
		assert_select 'div.alert', "New rider added!"
		get new_assignment_path
		assert_select 'input[value="Nate Shin"]'
	end
end
