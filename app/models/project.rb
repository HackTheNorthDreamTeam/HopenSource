class Project < ActiveRecord::Base
	has_many :users, through: :memberships, class_name: 'User', source: :user  
	belongs_to :organization
end
