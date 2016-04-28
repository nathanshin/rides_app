class Assignment < ActiveRecord::Base
	attr_accessor :included_drivers
	attr_accessor :included_riders

	validates :event, presence: true
	validates :date, presence: true

	serialize :assignments
	serialize :included_drivers
	serialize :included_riders

	before_save :arrange_rides
	delegate :arrange_rides, to: :arranger

	def arranger
		Arranger.new(self)
	end
end
