class Assignment < ActiveRecord::Base
	scope :ordered_by_date, -> { order(date: :desc) } 
	
	attr_accessor :included_drivers
	attr_accessor :included_riders

	validates :event, presence: true
	validates :date, presence: true
	validates :location, presence: true
	validates :included_drivers, presence: {message: "must check at least 1 driver"}
	validates :included_riders, presence: true

	serialize :assignments
	serialize :included_drivers
	serialize :included_riders

	before_save :arrange_rides
	delegate :arrange_rides, to: :arranger

	def arranger
		Arranger.new(self)
	end
end
