module ApplicationHelper
	def name_to_attribute(name)
		name = name.downcase
		name = name.split(' ')
		name = name.join('-')
	end
end
