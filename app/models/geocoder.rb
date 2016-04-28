class Geocoder
	def initialize(user)
		@user = user
	end

	def update_geocode
		address = @user.address
		geocode = Geokit::Geocoders::GoogleGeocoder.geocode address
		@user.geocode = geocode
	end
end