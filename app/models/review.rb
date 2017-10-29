class Review < ActiveRecord::Base
	belongs_to :restaurant
	
	validates :restaurant, presence: true
	validates :rating, presence: true
	validates :body, presence: true
end