class Item < ActiveRecord::Base

	# General validations
	validates :name, length: { minimum: 3 }, presence: true, uniqueness: true
	validates :description, length: { minimum: 5 }, presence: true
	validates :url, length: { minimum: 8 }, presence: true, uniqueness: true
	validates :image_url, length: { minimum: 4}, presence: true
	validates :type, length: { minimum: 3}, presence: true
	validates :category, length: { minimum: 3 }, presence: true

	# With that, I can have a field called type without an relationship
	self.inheritance_column = nil

end
