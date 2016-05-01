class Driver < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper

	scope :ordered_by_name, -> { order(name: :asc) }

	before_save :update_geocode
	before_save { email.downcase! }
	before_save :format_phone

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	validates :phone, presence: true
	validates :address, presence: true
	validates :car_spots, presence: true

	serialize :geocode
	delegate :update_geocode, to: :geocoder

	def geocoder
		Geocoder.new(self)
	end

	def format_phone
		self[:phone] = number_to_phone(phone)
	end
end